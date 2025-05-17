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
