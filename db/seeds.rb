# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email: "user1@example.com", full_name: "User 1") do |user|
  user.password = "verylongpassword!"
end

User.find_or_create_by!(email: "user2@example.com", full_name: "User 2") do |user|
  user.password = "verylongpassword!"
end

User.find_or_create_by!(email: "david@example.com", full_name: "David Lowenfels", github_username: "dfl") do |user|
  user.password = "verylongpassword!"
end

project = Project.find_or_create_by!(name: "Project 1")

project.comments.find_or_create_by!(user: User.find_by_full_name("User 1"),
  text: "This is a comment")
project.comments.find_or_create_by!(user: User.find_by_full_name("User 2"),
  text: "This is another comment")
project.comments.find_or_create_by!(user: User.find_by_full_name("David Lowenfels"),
  text: "Thanks team!")
