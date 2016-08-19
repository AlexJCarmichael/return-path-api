class Link < ApplicationRecord
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :url, presence: true
  validates :title, presence: true

  def aggregate_vote_count
    self.votes.where(vote_type: "up").count - self.votes.where(vote_type: "down").count
  end

  def as_json(_= nil)
    super(:include => { :comments => { methods: [:aggregate_vote_count] }},
          methods: [:aggregate_vote_count])
  end
end
