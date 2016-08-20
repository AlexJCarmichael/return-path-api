require 'rails_helper'

RSpec.describe Api::V1::VotesController do
  describe "GET index" do
    it "returns a successful 200 response" do
       get :index, format: :json
      expect(response).to be_success
    end

    it "returns all the votes" do
      FactoryGirl.create_list(:vote, 5)
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"].length).to eq(5)
    end
  end

  describe "GET show" do
    let(:vote) { FactoryGirl.create(:vote) }

    it "returns a successful 200 response" do
      get :show, params: { id: vote.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["vote_type"]).to eq("up")
    end

    it "returns data of an single vote" do
      get :show, params: { id: vote.id }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]).to_not be_nil
    end

    it "returns an error if the vote does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['response']).to eq("Vote does not exist")
      expect(response).to be_not_found
    end
  end

  describe "POST create" do
    context "given proper attributes" do
        it "creates a new vote" do
          link = Link.create(url: "My cool url", title: "My cool title")
          expect {
            post :create, params: { vote: { vote_type: "up", votable_type: "Link", votable_id: link.id } }
          }.to change(Vote, :count).by(1)
          expect(response).to be_success
          parsed_response = JSON.parse(response.body)
          expect(parsed_response["data"]["vote_type"]).to eq("up")
      end

      it "creates a new down vote" do
        link = Link.create(url: "My cool url", title: "My cool title")
        expect {
          post :create, params: { vote: { vote_type: "down", votable_type: "Link", votable_id: link.id } }
        }.to change(Vote, :count).by(1)
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["data"]["vote_type"]).to eq("down")
      end

      it "creates a new down vote for a comment" do
        link = Link.create(url: "My cool url", title: "My cool title")
        comment = Comment.create(body: "My cool comment", link: link)
        expect {
          post :create, params: { vote: { vote_type: "down", votable_type: "Comment", votable_id: comment.id } }
        }.to change(Vote, :count).by(1)
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["data"]["vote_type"]).to eq("down")
      end
    end

    context "missing attributes" do
      it "fails to create a vote" do
        link = Link.create(url: "My cool url", title: "My cool title")
        expect {
          post :create, params: { vote: { votable_type: "Link", votable_id: link.id } }
        }.to change(Vote, :count).by(0)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["response"]).to eq("Vote could not be created")
      end
    end

    context "wrong attributes" do
      it "won't create a vote" do
        link = Link.create(url: "My cool url", title: "My cool title")
        expect {
          post :create, params: { vote: { vote_type: "foobar", votable_type: "Link", votable_id: link.id } }
        }.to change(Vote, :count).by(0)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["response"]).to eq("Vote could not be created")
        expect(parsed_response["data"]["vote_type"]).to eq(["is not included in the list"])
      end
    end
  end

  describe "DELETE destroy" do
    let(:vote) { FactoryGirl.create(:vote) }

    it "returns a successful 200 response" do
      delete :destroy, params: { id: vote.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["response"]).to eq("Vote destroyed")
    end

    it "returns an error if the vote does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["response"]).to eq("Vote does not exist")
      expect(response).to be_not_found
    end
  end
end
