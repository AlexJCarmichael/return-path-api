FactoryGirl.define do
  factory :up_vote do
    vote_type "up"
    votable { |a| a.association(:link) }
  end
end
