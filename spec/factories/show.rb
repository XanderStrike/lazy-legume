FactoryGirl.define do
  factory :show do
    sequence(:name) { |n| "Show #{n}" }
    sequence(:tvdb_id) { |n| n }

    factory :show_with_episodes do
      after(:create) do |show|
        create_list(:episode, 5, show: show)
      end
    end
  end
end
