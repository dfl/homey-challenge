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

password = "1verylongpassword!"
User.find_or_create_by!(email: "simon@example.com", full_name: "Simon Smith") do |user|
  user.password = password
  user.github_username = "simonsmith"
end

User.find_or_create_by!(email: "bob@example.com", full_name: "Bob Mackie") do |user|
  user.password = password
  user.github_username = "bob"
end

User.find_or_create_by!(email: "david@example.com", full_name: "David Lowenfels") do |user|
  user.password = password
  user.github_username = "dfl"
end

project = Project.find_or_create_by!(name: "Project 1")

statuses = Project.statuses.keys[1..-1]

10.times do |i|
  user = User.find(User.pluck(:id).sample)
  if rand > 0.5
    project.comments.find_or_create_by! user:,
      text: Faker::Lorem.sentence, created_at: i.days.ago
  else
    Current.session = FactoryBot.create(:session, user:)
    project.update_attribute(:status, statuses.sample)
    project.status_changes.last.update_attribute(:created_at, i.days.ago)
  end
end
