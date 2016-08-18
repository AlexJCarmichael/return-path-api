class Link < ApplicationRecord
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :url, presence: true
  validates :title, presence: true
end
