class Endpoint < ApplicationRecord
  belongs_to :database_credential
  has_many :access_level_endpoints, dependent: :destroy
  has_many :access_levels, through: :access_level_endpoints
  has_many :tokens, through: :access_levels

  validates :query, presence: true
  validates :is_active, inclusion: { in: [true, false] }
  validates :replaced_fields_required, inclusion: { in: [true, false] }
  validates :name, presence: true, uniqueness: true

  scope :active, -> { where(is_active: true) }

  rails_admin do
    fields :name,
           :query,
           :is_active,
           :access_levels,
           :database_credential,
           :tokens,
           :replaced_fields_required

    exclude_fields :access_level_endpoints
  end
end
