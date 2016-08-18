class Comment < ApplicationRecord
  belongs_to :link

  has_many :votes, as: :votable

  validates :body, presence: true
end
