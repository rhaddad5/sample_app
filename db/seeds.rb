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
User.create!(name: "Roxane Haddad", email: "roxane.haddad@gmail.com", password: "123456", password_confirmation: "123456", admin: true, activated: true, activated_at: Time.zone.now)
puts "Main user created"
puts "Creating 99 other users"
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end
puts "100 users created"
puts "Destroying microposts"
Micropost.destroy_all
puts "Microposts destroyed"
puts "Creating microposts"
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    user.microposts.create!(content: content)
  end
end
puts "Microposts created"
puts "Creating relationships"
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each do |followed|
  user.follow(followed)
end
followers.each do |follower|
  follower.follow(user)
end
puts "Relationships created"

