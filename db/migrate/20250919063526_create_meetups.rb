class CreateMeetups < ActiveRecord::Migration[8.0]
  def change
    create_table :meetups do |t|
      t.string :title
      t.string :subject
      t.datetime :datetime
      t.string :location
      t.integer :max_participants
      t.integer :organizer_id
      t.integer :club_id

      t.timestamps
    end
  end
end
