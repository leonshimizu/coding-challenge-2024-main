# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def index
    @orders = if current_user.customer_care?
                Order.all
              elsif current_user.doctor?
                Order.where(doctor_id: current_user.id)
              else
                Order.where(user_id: current_user.id)
              end
  end
end
