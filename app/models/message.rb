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
# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id", optional: true
  belongs_to :order

  # Scope for visibility based on user role
  scope :visible_to, ->(user) {
    case user.role
    when "customer_care"
      all
    when "user"
      where(order_id: Order.where(user_id: user.id))
        .where("user_id = :user_id OR recipient_id = :user_id", user_id: user.id)
    when "doctor"
      where(order_id: Order.where(doctor_id: user.id))
        .where("user_id = :user_id OR recipient_id = :user_id", user_id: user.id)
    else
      none
    end
  }
end
