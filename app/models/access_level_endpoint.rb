class AccessLevelEndpoint < ApplicationRecord
  belongs_to :access_level
  belongs_to :endpoint

  rails_admin { visible(false) }
end
