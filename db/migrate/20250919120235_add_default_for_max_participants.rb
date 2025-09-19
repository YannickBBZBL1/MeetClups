class AddDefaultForMaxParticipants < ActiveRecord::Migration[8.0]
  def change
    change_column_default :meetups, :max_participants, 0
  end
end
