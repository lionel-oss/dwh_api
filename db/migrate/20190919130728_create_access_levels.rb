class CreateAccessLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :access_levels do |t|
      t.text :description
      t.timestamps
    end
  end
end
