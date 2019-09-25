class AccessLevelEndpoint < ApplicationRecord
  belongs_to :access_level
  belongs_to :endpoint

  validates :access_level_id, uniqueness: { scope: :endpoint_id }

  rails_admin { visible(false) }
end
