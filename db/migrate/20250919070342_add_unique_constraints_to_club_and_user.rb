class AddUniqueConstraintsToClubAndUser < ActiveRecord::Migration[8.0]
  def change
    add_index :clubs, :title, unique: true
    add_index :users, :username, unique: true
  end
end
