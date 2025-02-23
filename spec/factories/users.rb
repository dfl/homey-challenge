# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  full_name       :string
#  github_username :string
#  password_digest :string           not null
#  verified        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'SecurePassword123!' }
    verified { false }
    full_name { Faker::Name.name }

    trait :verified do
      verified { true }
    end
  end
end
