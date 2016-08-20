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
end
