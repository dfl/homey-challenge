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
