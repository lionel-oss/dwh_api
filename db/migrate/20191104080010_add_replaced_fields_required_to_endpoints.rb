class AddReplacedFieldsRequiredToEndpoints < ActiveRecord::Migration[5.2]
  def change
    add_column :endpoints, :replaced_fields_required, :boolean, null: false, default: true
  end
end
