class Token < ApplicationRecord
  belongs_to :access_level

  validates :name, presence: true, uniqueness: true
  has_secure_token :code
end
