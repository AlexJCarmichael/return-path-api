require 'rails_helper'

RSpec.describe Link, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryGirl.create(:link)).to be_valid
  end

  it "is not valid when missing a url" do
    expect(Link.create(title: "My cool title")).to_not be_valid
  end

  it "is not valid when missing a title" do
    expect(Link.create(url: "My cool url")).to_not be_valid
  end

  it "has many votes" do
    link = FactoryGirl.create(:link_with_votes)
    expect(link.votes.count).to be_between(1, 4).inclusive
  end

  it "has a vote count" do
    link = FactoryGirl.create(:link_with_votes)
    expect(link.aggregate_vote_count).to be_between(-4, 4).inclusive
  end

  it "has many comments" do
    link = FactoryGirl.create(:link_with_comments)
    expect(link.comments.count).to be_between(2, 5).inclusive
  end

  it "has many sorted comments" do
    link = FactoryGirl.create(:link_with_comments)
    compare = link.sorted_comments.second.aggregate_vote_count
    expect(link.sorted_comments.first.aggregate_vote_count).to_not be < compare
  end

  it "has a vote count in JSON" do
    link = FactoryGirl.create(:link_with_votes)
    expect(link.as_json["aggregate_vote_count"]).to be_between(-4, 4).inclusive
  end

  it "has sorted comments in JSON" do
    json_link = FactoryGirl.create(:link_with_comments).as_json
    expected = json_link["sorted_comments"].first.aggregate_vote_count
    compare = json_link["sorted_comments"].second.aggregate_vote_count
    expect(expected).to_not be < compare
  end
end
