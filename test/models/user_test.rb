# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  credit_card_number     :string
#  cvv                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  expiry                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("user"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @order = orders(:one)
  end

  test "user can see associated orders" do
    assert_includes @user.orders, @order
  end

  test "doctor can see doctor orders" do
    doctor = users(:two)
    assert_includes doctor.doctor_orders, @order
  end
end
