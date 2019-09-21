class AccessLevel < ApplicationRecord
  has_many :tokens
  has_many :access_level_endpoints
  has_many :endpoints, through: :access_level_endpoints

  rails_admin do
    list do
      field :id do
        label 'Access level'
      end
      fields :description, :endpoints, :tokens
    end

    exclude_fields :access_level_endpoints, :tokens

    object_label_method do
      :custom_label_method
    end
  end

  def custom_label_method
    "level #{self.id}"
  end

end
