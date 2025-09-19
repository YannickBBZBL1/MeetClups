class CreateClubs < ActiveRecord::Migration[8.0]
  def change
    create_table :clubs do |t|
      t.string :title
      t.text :description
      t.integer :admin_id

      t.timestamps
    end
  end
end
