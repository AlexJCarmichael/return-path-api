FactoryGirl.define do
  factory :down_vote do
    vote_type "down"
    votable { |a| a.association(:comment) }
  end
end
