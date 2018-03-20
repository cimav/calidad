module ApplicationHelper
  def active_class(link_path)
    "active" if request.path.start_with?(link_path)
  end
end
