class Link < ApplicationRecord
  has_many :votes, as: :votable
  has_many :comments

  validates :url, presence: true
  validates :title, presence: true
end
