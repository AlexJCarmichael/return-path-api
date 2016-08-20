FactoryGirl.define do
  factory :comment do
    body "Comment body"
    link

    factory :comment_with_votes do
      after(:create) do |comment|
        rand(1..4).times do
          create(:vote, votable: comment, vote_type: %w(up down).sample)
        end
      end
    end
  end
end
