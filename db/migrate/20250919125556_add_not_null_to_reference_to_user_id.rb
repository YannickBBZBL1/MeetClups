class AddNotNullToReferenceToUserId < ActiveRecord::Migration[8.0]
  def change
    change_column_null :meetups, :organizer_id, false
  end
end
