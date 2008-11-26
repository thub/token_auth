# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  before_filter :check_token
  before_filter :check_user
  
  def check_token
    if token_is_on_request?
      set_token_in_session
    elsif token_is_in_session?
      # do nothing
    else
      redirect_to :controller=>"Users", :action=>"new" 
      return
    end
  end
  
  def token_is_in_session?
    session[:token]!=nil  
  end

  def token_is_on_request?
    params[:token]!=nil
  end
  
  def set_token_in_session
    session[:token] = params[:token]
  end  
  
  
  def check_user
    logger.info("token from session is "+session[:token])
    current_user = User.find_by_token(session[:token])
    if current_user == nil
      redirect_to :controller=>"Users",:action=>"new"             
      return
    else
      session[:current_user] = current_user
    end
  end
    
  
  def current_user
    session[:current_user]
  end
  

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0e2c99506654cadd00f747e3b301d6e2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
