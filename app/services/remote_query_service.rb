class RemoteQueryService
  def initialize(endpoint, replace_values)
    @endpoint = endpoint
    @replace_values = replace_values
  end

  def call
    return format_result(404, message: 'endpoint not found') if @endpoint.nil?

    query = query_with_replaced_fields

    response = RemoteDatabase::Postgres.new(
      *arguments_for_remote_database
    ).run_query(query)
    format_result(200, result: response)
  rescue
    format_result(400, message: 'Bad request, please check URL and parameters')
  end

  private

  def query_with_replaced_fields
    replace_fields = @endpoint.query.scan(/%{(.+?)}/).flatten.uniq
    return @endpoint.query if replace_fields.empty?

    query = @endpoint.query
    replace_fields.each do |field|
      field_value = fetch_field_value(@replace_values[field])
      query = query.gsub("%{#{field}}", field_value)
    end
    query
  end

  def arguments_for_remote_database
    [
      @endpoint.database_credential.host,
      @endpoint.database_credential.port,
      @endpoint.database_credential.database,
      @endpoint.database_credential.user,
      @endpoint.database_credential.password
    ]
  end

  def format_result(status, response)
    { status: status, response: response }
  end

  def fetch_field_value(value)
    if @endpoint.replaced_fields_required
      value
    else
      value ? value : 'NULL'
    end
  end
end
