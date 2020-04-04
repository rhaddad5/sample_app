# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying users"
User.destroy_all
puts "Users destroyed"
puts "Creating main user"
roxane = User.create!(name: "Roxane Haddad", email: "roxane.haddad@gmail.com", password: "123456", password_confirmation: "123456", admin: true, activated: true, activated_at: Time.zone.now)
puts "Main user created"
puts "Creating 99 other users"
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end
puts "100 users created"

roxane.microposts.create!(content: "petit test de micropost")
