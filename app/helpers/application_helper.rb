# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def current_user
    session[:current_user]
  end
  
  def user_logged_in?
    current_user!=nil
  end
  
end
