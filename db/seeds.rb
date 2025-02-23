# require 'faker'
# require 'factory_bot'

password = "1verylongpassword!"
User.find_or_create_by!(email: "simon@example.com", full_name: "Simon Smith") do |user|
  user.password = password
  user.github_username = "simonsmith"
end

User.find_or_create_by!(email: "bob@example.com", full_name: "Bob Mackie") do |user|
  user.password = password
  user.github_username = "bob"
end

User.find_or_create_by!(email: "madhura@example.com", full_name: "Madhura Sharma") do |user|
  user.password = password
  user.github_username = "mbhave"
end

User.find_or_create_by!(email: "david@example.com", full_name: "David Lowenfels") do |user|
  user.password = password
  user.github_username = "dfl"
end


project = Project.find_or_create_by!(name: "Project 1")
desired_statuses = Project.statuses.keys[1..-1]

10.times do |i|
  user = User.find(User.pluck(:id).sample)
  if rand > 0.3
    project.comments.create! user:, body: Faker::Lorem.sentence
  else
    Current.session = Session.create!(user: user) # login user so Current.user is set for status changes
    project.update_attribute(:status, desired_statuses.sample)
  end
  project.events.last.update(created_at: i.days.ago)
end
