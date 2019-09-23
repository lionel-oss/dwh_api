class CreateAccessLevelEndpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :access_level_endpoints do |t|
      t.references :access_level, index: true
      t.references :endpoint, index: true
      t.timestamps
    end
  end
end
