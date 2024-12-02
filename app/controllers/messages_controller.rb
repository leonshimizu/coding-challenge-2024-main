# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
    def index
      @messages = Message.visible_to(current_user)
    end
  
    def create
        @message = Message.new(message_params)
        @message.user = current_user # Automatically set the sender
      
        @orders = if current_user.customer_care?
                    Order.all
                  elsif current_user.doctor?
                    current_user.doctor_orders
                  else
                    current_user.orders
                  end
      
        if @message.save
          redirect_to orders_path, notice: "Message sent successfully!"
        else
          flash.now[:error] = "Message failed to send: #{@message.errors.full_messages.join(', ')}"
          render "orders/index", status: :unprocessable_entity
        end
      end      
  
    private
  
    def message_params
      params.require(:message).permit(:message, :order_id, :recipient_id)
    end
  end
  