# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding database..."
User.destroy_all

User.create!(
  email_address: "user@gmail.com",
  password: "q1w2e3r4",
  password_confirmation: "q1w2e3r4",
  username: "user",
  role: 1
)
