module ApplicationHelper
  def current_user_has?(instance)
    logged_in? && current_user == instance.user || logged_in? && current_user.admin?
  end
end
