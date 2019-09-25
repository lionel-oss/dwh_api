class AddUniquenessConstraintToAccessLevelEndpoints < ActiveRecord::Migration[5.2]
  def change
    remove_index :access_level_endpoints, :access_level_id
    remove_index :access_level_endpoints, :endpoint_id
    add_index :access_level_endpoints, [ :access_level_id, :endpoint_id ], unique: true
  end
end
