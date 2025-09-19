class MakeColumnsNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :meetups, :title, false
    change_column_null :meetups, :datetime, false
    change_column_null :meetups, :location, false
    change_column_null :clubs, :title, false
    change_column_null :clubs, :admin_id, false
  end
end
