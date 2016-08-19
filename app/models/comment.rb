class Comment < ApplicationRecord
  belongs_to :link

  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true

  def aggregate_vote_count
    self.votes.where(vote_type: "up").count - self.votes.where(vote_type: "down").count
  end

  def as_json(_= nil)
    super(methods: [:aggregate_vote_count])
  end
end
