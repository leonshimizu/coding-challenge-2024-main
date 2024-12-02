require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Ensure users.yml has a fixture for a user
    @doctor = users(:two) # Ensure users.yml has a fixture for a doctor
    @customer_care = users(:three) # Ensure users.yml has a fixture for a customer care user
    @order = orders(:one) # Ensure orders.yml has a fixture for an order

    sign_in @user # Devise helper to sign in users
  end

  test "should create message and redirect" do
    assert_difference("Message.count") do
      post messages_url, params: { message: { message: "Test Message", order_id: @order.id, recipient_id: @doctor.id } }
    end

    assert_redirected_to orders_path
  end

  test "should not create message with invalid data" do
    assert_no_difference("Message.count") do
      post messages_url, params: { message: { message: "", order_id: nil, recipient_id: @doctor.id } }
    end

    assert_response :unprocessable_entity
  end
end
