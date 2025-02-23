FactoryBot.define do
  factory :project_comment, class: 'Project::Comment' do
    association :user
    association :project
    body { Faker::Lorem.paragraph }

    trait :empty do
      body { "" }
    end

    factory :comment do  # Alias for project_comment
      # Add any specific traits or attributes for the :comment alias here if needed
    end
  end
end
