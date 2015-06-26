FactoryGirl.define do
  factory :feed do
    sequence(:name) { |n| "Feed #{n}" }
    sequence(:url) { |n| "http://lolztracker.com/rss.php?k=#{n}" }
  end
end
