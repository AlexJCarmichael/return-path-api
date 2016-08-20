class Vote < ApplicationRecord
  before_validation :sanitize_votable_type, :sanitize_vote_type

  belongs_to :votable, polymorphic: :true

  validates :vote_type, inclusion: { in: %w(up down) }
  validates :votable_type, inclusion: { in: %w(Link Comment) }
  validates :votable_id, presence: true

  def sanitize_votable_type
    return self.votable_type.capitalize! if self.votable_type
  end

  def sanitize_vote_type
    return self.vote_type.downcase! if self.vote_type
  end
end
