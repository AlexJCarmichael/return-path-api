FactoryGirl.define do
  factory :link do
    url "test_url"
    title "test_title"

    factory :link_with_votes do
      after(:create) do |link|
        rand(1..4).times do
          create(:vote, votable: link, vote_type: %w(up down).sample)
        end
      end
    end

    factory :link_with_comments do
      after(:create) do |link|
        rand(2..5).times do
          create(:comment_with_votes, link: link)
        end
      end
    end
  end
end
