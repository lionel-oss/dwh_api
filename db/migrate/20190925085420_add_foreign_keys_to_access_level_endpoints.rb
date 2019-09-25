class AddForeignKeysToAccessLevelEndpoints < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :access_level_endpoints, :access_levels, on_delete: :cascade
    add_foreign_key :access_level_endpoints, :endpoints, on_delete: :cascade
  end
end
