require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it "is not valid when missing a body" do
    link = Link.create(title: "My cool title", url: "My cool url")
    expect(Comment.create(link: link)).to_not be_valid
  end

  it "is not valid when missing a link" do
    expect(Comment.create(body: "My cool body")).to_not be_valid
  end

  it "has many votes" do
    comment = FactoryGirl.create(:comment_with_votes)
    expect(comment.votes.count).to be_between(1, 4).inclusive
  end

  it "has a vote count" do
    comment = FactoryGirl.create(:comment_with_votes)
    expect(comment.aggregate_vote_count).to be_between(-4, 4).inclusive
  end

  it "has a vote count in JSON" do
    comment = FactoryGirl.create(:comment_with_votes)
    expect(comment.as_json["aggregate_vote_count"]).to be_between(-4, 4).inclusive
  end
end
