class MessagesController < ApplicationController

  def index
    @messages = Message.find(:all)
    @message = Message.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end



  def edit
    @message = Message.find(params[:id])
    unless @message.owner.id == current_user.id
      flash[:notice] = 'Hey stop it!'
      redirect_to messages_path
      return
    end
  end


  def create
    @message = Message.new(params[:message])
    @message.owner = current_user

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    unless @message.owner.id == current_user.id
      flash[:notice] = 'Hey stop it!'
      redirect_to messages_path
      return
    end

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @message = Message.find(params[:id])

    unless @message.owner.id == current_user.id
      flash[:notice] = 'Hey stop it!'
      redirect_to messages_path
      return
    end

    @message.destroy


    respond_to do |format|
      format.html { redirect_to(messages_url) }
    end
  end
  
end

