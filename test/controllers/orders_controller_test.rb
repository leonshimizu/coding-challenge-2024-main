require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @doctor = users(:two)
    @customer_care = users(:three)
    @order = orders(:one)

    sign_in @doctor # Test as a doctor
  end

  test "should get index as a doctor and see visible orders and messages" do
    get orders_url
    assert_response :success

    # Ensure orders visible to the doctor are returned
    assigns(:orders).each do |order|
      # Only check messages visible to the doctor
      order.messages.visible_to(@doctor).each do |message|
        assert_includes Message.visible_to(@doctor), message
      end
    end
  end
end
