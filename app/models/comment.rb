class Comment < ApplicationRecord
  belongs_to :link

  has_many :votes, as: :votable, dependent: :destroy

  validates :body, presence: true
end
