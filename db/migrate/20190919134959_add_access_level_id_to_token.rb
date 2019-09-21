class AddAccessLevelIdToToken < ActiveRecord::Migration[5.2]
  def change
    add_reference :tokens, :access_level, index: true
  end
end
