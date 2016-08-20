FactoryGirl.define do
  factory :vote do
    vote_type "up"
    votable { |a| a.association(:link) }
  end
end
