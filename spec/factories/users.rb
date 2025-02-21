FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'SecurePassword123!' }
    verified { false }

    trait :verified do
      verified { true }
    end
  end
end
