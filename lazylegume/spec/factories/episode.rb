FactoryGirl.define do
  factory :episode do
    sequence(:name) {|n| "Episode #{n} S#{rand(99).to_s.rjust(2, "0")}E#{rand(99).to_s.rjust(2, "0")}"}
    sequence(:link) {|n| "https://lolztracker.com/download.php?id=#{n * 50}"}

    factory :episode_with_show do
      show
    end
  end
end
