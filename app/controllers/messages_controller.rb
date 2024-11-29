class MessagesController < ApplicationController
    def index
      # Fetch only messages visible to the current user
      @messages = Message.visible_to(current_user)
    end
  
    def create
      @message = Message.new(message_params)
  
      # Assign the correct association based on the user's role
      if current_user.doctor?
        @message.doctor = current_user
      elsif current_user.customer_care?
        @message.user = current_user
      else
        @message.user = current_user
      end
  
      # Save the message and handle errors
      if @message.save
        redirect_to orders_path
      else
        flash[:error] = "Message failed to send: #{@message.errors.full_messages.join(', ')}"
        redirect_to orders_path
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:message, :order_id, :user_id)
    end
  end
  