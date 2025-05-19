# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
puts "Seeding database..."
OrderDetail.delete_all
Order.delete_all
Inventory.delete_all
Product.delete_all
Category.delete_all
Supplier.delete_all
Payment.delete_all
Order.destroy_all
User.destroy_all

puts "### Creating admin user... ###"
User.create!(
  email_address: "user@gmail.com",
  password: "q1w2e3r4",
  password_confirmation: "q1w2e3r4",
  username: "user",
  role: 1
)

20.times do |i|
  User.create!(
    email_address: Faker::Internet.email,
    password: "q1w2e3r4",
    password_confirmation: "q1w2e3r4",
    username: Faker::Internet.username,
    role: 1
  )
end

puts "### Creating orders... ###"
20.times do |i|
  Order.create!(
    user_id: User.all.sample.id,
    amount: Faker::Commerce.price(range: 0..100.0, as_string: true),
    status: Order.statuses.keys.sample,
    ordered_at: Faker::Date.between(from: '2023-01-01', to: '2023-12-31')
  )
end

# Seed Categories
categories = 5.times.map do
  Category.create!(name: Faker::Commerce.department(max: 1))
end

# Seed Suppliers
suppliers = 5.times.map do
  Supplier.create!(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.phone_number,
    user_id: User.all.sample.id
  )
end

# Seed Products
puts "### Creating products... ###"
products = 20.times.map do
  Product.create!(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 1.0..100.0),
    category: categories.sample,
    supplier: suppliers.sample
  )
end

# Seed Inventories
puts "### Creating inventories... ###"
products.each do |product|
  Inventory.create!(product: product, stock: rand(10..100))
end

# Seed Payments
puts "### Creating payments... ###"
payments = %w[Cash Card E-Wallet Transfer].map do |name|
  Payment.create!(name: name)
end

puts "### Creating order details... ###"
# Seed Orders & OrderDetails

orders = Order.all
orders.each do |order|
  all_total = 0
  rand(1..5).times do
    product = products.sample
    quantity = rand(1..10)
    total = quantity * product.price
    OrderDetail.create!(
      order: order,
      product: product,
      quantity: quantity,
      unit_price: product.price,
      total: total,
    )
    all_total += total
  end
  order.update(
    amount: all_total,
    payment_id: payments.sample.id,
    discount: rand(0.0..10.0).round(2),
    service_fee: rand(0..5000),
  )
end
