require 'rails_helper'

RSpec.describe Vote, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryGirl.create(:vote)).to be_valid
  end

  it "is valid with down votes" do
    expect(FactoryGirl.create(:vote, vote_type: "down")).to be_valid
  end

  it "is valid with comments" do
    link = Link.create(url: "My cool url", title: "My cool title")
    comment = Comment.create(body: "My cool body", link: link)
    expect(FactoryGirl.create(:vote, votable: comment)).to be_valid
  end

  it "is valid with lowercase votable_type" do
    link = Link.create(url: "My cool url", title: "My cool title")
    comment = Comment.create(body: "My cool body", link: link)
    expect(Vote.create(votable_id: comment.id, votable_type: "comment", vote_type: "down")).to be_valid
  end

  it "is valid with uppercase vote_type" do
    link = Link.create(url: "My cool url", title: "My cool title")
    comment = Comment.create(body: "My cool body", link: link)
    expect(Vote.create(votable_id: comment.id, votable_type: "comment", vote_type: "DOWN")).to be_valid
  end

  it "is not valid when missing a vote_type" do
    expect(Vote.create(votable_id: 1, votable_type: "Link")).to_not be_valid
  end

  it "is not valid when missing a votable_id" do
    expect(Vote.create(vote_type: "up", votable_type: "Link")).to_not be_valid
  end

  it "is not valid when missing a votable_type" do
    expect(Vote.create(votable_id: 1, vote_type: "up")).to_not be_valid
  end

  it "is not valid with wrong vote_type" do
    link = Link.create(url: "My cool url", title: "My cool title")
    expect(Vote.create(votable_id: link.id, votable_type: "Link", vote_type: "george")).to_not be_valid
  end
end
