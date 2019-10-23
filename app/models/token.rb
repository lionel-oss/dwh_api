class Token < ApplicationRecord
  include ActionView::Helpers::UrlHelper

  belongs_to :access_level

  validates :name, presence: true, uniqueness: true
  has_secure_token :code

  rails_admin do
    list do
      fields :id, :code, :created_at, :access_level
      field :swagger_link do
        label 'Swagger'
      end
    end
  end

  def swagger_link
    link_to 'open doc', Rails.application.routes.url_helpers.swagger_docs_path(token: code)
  end
end
