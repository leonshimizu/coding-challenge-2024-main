# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

# Define order items
order_items = [{
  name: 'Rugiet ED Strong',
  dosage: '1 troche',
  quantity: 3,
  instructions: 'Take 1 troche 30 minutes before sex',
  price: 150.00
}]

# Create Users
user = User.create!(
  email: 'user@example.com',
  credit_card_number: '4111 1111 1111 1111',
  expiry: '08/27',
  cvv: 988,
  password: 'Password1!',
  role: :user
)

doctor = User.create!(
  email: 'doctor@example.com',
  password: 'Password1!',
  role: :doctor
)

customer_care = User.create!(
  email: 'customercare@example.com',
  password: 'Password1!',
  role: :customer_care
)

# Create Order
order = Order.create!(
  user: user,
  doctor: doctor,
  order_items: order_items,
  total: 450.00
)

# Create Messages between User and Doctor
Message.create!(
  user: user,
  recipient: doctor,
  order: order,
  message: "Can I get more information on this product?",
  created_at: Time.now - 3.days
)

Message.create!(
  user: doctor,
  recipient: user,
  order: order,
  message: "Sure! What do you need to know?",
  created_at: Time.now - 2.days
)

# Create Messages between User and Customer Care
Message.create!(
  user: user,
  recipient: customer_care,
  order: order,
  message: "Can you check the status of my order?",
  created_at: Time.now - 1.day
)

Message.create!(
  user: customer_care,
  recipient: user,
  order: order,
  message: "Your order is being reviewed by the doctor.",
  created_at: Time.now - 12.hours
)

# Create Messages between Doctor and Customer Care
Message.create!(
  user: doctor,
  recipient: customer_care,
  order: order,
  message: "Please confirm if the user's order is ready for review.",
  created_at: Time.now - 6.hours
)

Message.create!(
  user: customer_care,
  recipient: doctor,
  order: order,
  message: "The user's order has been approved and is ready for review.",
  created_at: Time.now - 3.hours
)
