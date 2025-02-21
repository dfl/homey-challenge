FactoryBot.define do
  factory :project_status_change do
    association :project
    association :user
    from_status { "pending" }
    to_status { "active" }
  end
end
