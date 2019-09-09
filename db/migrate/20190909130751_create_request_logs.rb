class CreateRequestLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :request_logs do |t|
      t.string :endpoint, null: false
      t.string :token, null: false
      t.string :status, null: false
      t.string :http_protocol, null: false
      t.float :db_duration, null: false
      t.float :total_duration, null: false
      t.string :error_message
      t.string :server_name
      t.jsonb :params, null: false, default: '{}'
      t.inet :ip_address, null: false
      t.boolean :email_sended, null: false, default: false

      t.timestamps
    end
  end
end
