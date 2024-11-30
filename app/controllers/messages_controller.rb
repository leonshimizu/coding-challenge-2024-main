# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
    def index
      @messages = Message.visible_to(current_user)
    end
  
    def create
      @message = Message.new(message_params)
      @message.user = current_user # Automatically set the sender
  
      if @message.save
        redirect_to orders_path, notice: "Message sent successfully!"
      else
        flash[:error] = "Message failed to send: #{@message.errors.full_messages.join(', ')}"
        redirect_to orders_path
      end
    end
  
    private
  
    def message_params
      params.require(:message).permit(:message, :order_id, :recipient_id)
    end
  end
  