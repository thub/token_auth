module MessagesHelper
  
  def is_owner(message,user)
    message.owner == user
  end 
  
end
