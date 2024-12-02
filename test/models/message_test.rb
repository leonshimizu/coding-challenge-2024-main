# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  message      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :integer          not null
#  recipient_id :integer
#  user_id      :integer
#
# Indexes
#
#  index_messages_on_order_id      (order_id)
#  index_messages_on_recipient_id  (recipient_id)
#  index_messages_on_user_id       (user_id)
#
# Foreign Keys
#
#  order_id  (order_id => orders.id)
#  user_id   (user_id => users.id)
#
# test/models/message_test.rb
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @doctor = users(:two)
    @customer_care = users(:three)
    @order = orders(:one)

    @message = Message.create!(
      user: @user,
      recipient: @doctor,
      order: @order,
      message: "Test Message"
    )
  end

  test "visible_to scope includes user and recipient" do
    assert_includes Message.visible_to(@user), @message
    assert_includes Message.visible_to(@doctor), @message
  end

  test "visible_to scope excludes unrelated users" do
    unrelated_user = User.create!(
      email: "unrelated_user@example.com",
      password: "Password1!",
      role: :user
    )
    refute_includes Message.visible_to(unrelated_user), @message
  end

  test "visible_to scope includes messages sent to customer care" do
    message_to_cc = Message.create!(
      user: @doctor,
      recipient: @customer_care,
      order: @order,
      message: "Message to Customer Care"
    )

    assert_includes Message.visible_to(@doctor), message_to_cc
    assert_includes Message.visible_to(@customer_care), message_to_cc
  end
end
