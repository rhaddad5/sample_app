# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require "open-uri"

puts "Destroying users"
User.destroy_all
puts "Users destroyed"
puts "Creating main user"
def image_fetcher_user
    open(Faker::Avatar.image)
    rescue
    open("https://robohash.org/sitsequiquia.png?size=300x300&set=set1")
end
def image_fetcher_post
    open(Faker::Avatar.image)
    rescue
    open("https://robohash.org/sitsequiquia.png?size=300x300&set=set4")
end
roxane = User.create!(name: "Roxane Haddad", email: "roxane.haddad@gmail.com", password: "123456", password_confirmation: "123456", admin: true, activated: true, activated_at: Time.zone.now)
roxane.photo.attach({
     io: image_fetcher_user,
     filename: "faker_image.jpg"
  })
puts "Main user created"
puts "Creating 99 other users"
39.times do |n|
  u = User.create!(name: Faker::Name.name, email: "example#{n}@example.com", password: "sample-password", password_confirmation: "sample-password", admin: false, activated: true, activated_at: Time.zone.now)
  u.photo.attach({
     io: image_fetcher_user,
     filename: "#{n}_faker_image.jpg"
  })
end
puts "100 users created"
puts "Destroying microposts"
Micropost.destroy_all
puts "Microposts destroyed"
puts "Creating microposts"
users = User.order(:created_at)
2.times do |i|
  content = Faker::Lorem.sentence(word_count: 5, random_words_to_add: 4)
  users.each do |user|
    m = Micropost.create!(content: content, user_id: user.id)
    m.image.attach({
      io: image_fetcher_post,
      filename: "#{i}_faker_image.jpg"
    })
  end
end
puts "Microposts created"
puts "Destroying relationships"
Relationship.destroy_all
puts "Relationships destroyed"
puts "Creating relationships"
users = User.all
following = users[0..40]
followers = users[0..40]
# following.each do |followed|
#   user.follow(followed)
# end
followers.each do |follower|
  following.each do |followed|
    follower.follow(followed)
  end
end
puts "Relationships created"

