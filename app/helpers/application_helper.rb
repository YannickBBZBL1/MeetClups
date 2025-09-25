module ApplicationHelper
  def user_name(user_id)
    User.find(user_id).username
  rescue ActiveRecord::RecordNotFound, TypeError
    "Unbekannt"
  end
end
