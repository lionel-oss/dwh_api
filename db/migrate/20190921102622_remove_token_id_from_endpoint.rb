class RemoveTokenIdFromEndpoint < ActiveRecord::Migration[5.2]
  def change
    remove_column :endpoints, :token_id
  end
end
