class RemoveNullFalseToDatabaseCredentials < ActiveRecord::Migration[5.2]
  def change
    change_column_null :database_credentials, :password, true
    change_column_null :database_credentials, :salt, true
  end
end
