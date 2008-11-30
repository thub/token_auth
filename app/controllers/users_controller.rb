class UsersController < ApplicationController
      
   skip_filter :check_token, :only =>[:new,:create,:show]  

  def show
    if user_logged_in?
      redirect_to :controller=>"Messages", :action=>"index"
      return
    end
    
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    token = generate_token
        
    existing_user = User.find_by_email(@user.email)
    if existing_user !=nil
      existing_user.token = token
      existing_user.save
      send_token_email_to_existing_user existing_user
      flash[:notice] = "Email with entry link was successfully sent to #{existing_user.email}"
      redirect_to (existing_user)
      return
    else
      @user.token = token
      @user.save
      send_token_email_to_new_user @user
      flash[:notice] = "Email with entry link was successfully sent to #{@user.email}"
      redirect_to (@user)
      return
    end
  end

  def generate_token
    ActiveSupport::SecureRandom.hex(50)
  end

  def send_token_email_to_existing_user(user)  
    logger.info "Sending token to existing user #{user.token} to #{user.email}"
    Mailer.deliver_existing_user_token_notification(user)
    
  end
  
  def send_token_email_to_new_user(user)  
    logger.info "Sending token to new user #{user.token} to #{user.email}"
    Mailer.deliver_new_user_token_notification(user)    
  end
  



end
