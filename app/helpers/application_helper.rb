module ApplicationHelper
  def active_class(link_path)
    "active" if request.path.start_with?("/#{link_path}")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
