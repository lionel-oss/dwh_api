class AddNameToDatabasecredentials < ActiveRecord::Migration[5.2]
  def change
    add_column :database_credentials, :name, :string
  end
end
