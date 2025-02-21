FactoryBot.define do
  factory :project do
    name { Faker::Company.unique.name }
    status { Project.statuses.keys.sample }

    after(:build) do |project|
      project.status ||= :pending
    end
  end
end
