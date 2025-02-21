FactoryBot.define do
  factory :comment do
    association :user
    association :project
    text { "Test comment" }
  end
end
