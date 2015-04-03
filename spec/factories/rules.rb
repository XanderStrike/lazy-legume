FactoryGirl.define do
  factory :rule do
    sequence(:regex) {|n| "Show #{n}"}

    factory :rule_with_feed_and_show do
      feed
      show
    end
  end
end
