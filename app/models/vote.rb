class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: :true

  validates :vote_type, inclusion: { in: ["up", "down"] }
  validates :votable_type, inclusion: { in: ["Link", "Comment"] }
  validates :votable_id, presence: true
end
