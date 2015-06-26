FactoryGirl.define do
  factory :rule do
    sequence(:regex) { |n| "Show #{n}" }
    feed
    show
  end
end
