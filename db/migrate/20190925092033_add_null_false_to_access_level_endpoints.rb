class AddNullFalseToAccessLevelEndpoints < ActiveRecord::Migration[5.2]
  def change
    change_column_null :access_level_endpoints, :access_level_id, false
    change_column_null :access_level_endpoints, :endpoint_id, false
  end
end
