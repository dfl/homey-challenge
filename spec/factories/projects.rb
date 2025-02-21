FactoryBot.define do
  factory :project do
    name { Faker::Company.unique.name }
    status { :pending }
  end
end
