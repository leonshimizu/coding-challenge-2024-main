class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show edit update destroy]

  # GET /orders or /orders.json
  def index
    @orders = if current_user.customer_care?
                Order.all
              elsif current_user.doctor?
                current_user.doctor_orders
              else
                current_user.orders
              end
    puts "Orders: #{@orders.inspect}"
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
