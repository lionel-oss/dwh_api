class SwaggerController < ActionController::Base
  layout 'swagger', only: :swagger_docs

  before_action :generate_docs, except: [:swagger_docs]

  def swagger_docs
    token = Token.find_by(code: params[:token])
    access_level = token&.access_level
    session[:accessible_endpoints] = access_level ? access_level.endpoints.pluck(:name) : ''
  end

  def api_docs
    result = Swagger::Docs::Generator.generate_docs.values.first
    @root = result[:root]
    @root.delete 'resources'
    @root['basePath'] = Rails.application.config.site_url
    proceed_root_apis
    render json: @root.to_json
  end

  def resource_docs
    generated_doc = send(params[:resource_name]) if respond_to? params[:resource_name]
    render json: generated_doc
  end

  private

  def generate_docs
    resources = Swagger::Docs::Generator.generate_docs.values.first[:root]['resources']
    resources.first['apis'] += generate_custom_api_docs if resources.first

    resources.each do |resource|
      resource_file_path = resource.delete 'resourceFilePath'
      self.class.send :define_method, resource_file_path do
        Rails.logger.info session[:accessible_endpoints]
        resource.to_json
      end
    end
  end

  def proceed_root_apis
    @root[:apis].reject! do |api|
      resource_name = api[:path][/\w+/]
      !respond_to?(resource_name) || JSON.parse(send(resource_name))['apis'].blank?
    end
    @root[:apis].each { |api| api[:path] = "/docs#{api[:path]}" }
  end

  def generate_custom_api_docs
    api_queries = Endpoint.where(name: session[:accessible_endpoints])
    api_queries.each_with_object([]) do |query, result|

      result << {
        path: "/#{query.name}",
        operations: [{
                        summary: query.name,
                        parameters: generate_params(query),
                        responseMessages: [{
                                             cod: 401,
                                             responseModel: nil,
                                             message: 'Unauthorized'
                                           }],
                        nickname: "Endpoints##{query.name}",
                        method: 'get'
                    }]
      }
    end
  end

  def generate_params(endpoint)
    replace_fields = endpoint.query.scan(/%{(.+?)}/).flatten.uniq
    params = replace_fields.map do |field|
      {
        paramType: 'query',
        name: field,
        type: 'string',
        description: 'Replaceable field',
        required: true
      }
    end

    params << {
      paramType: 'query',
      name: 'token',
      type: 'string',
      description: 'User Token',
      required: true
    }
  end
end
