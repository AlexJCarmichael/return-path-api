require 'rails_helper'

RSpec.describe Api::V1::CommentsController do
  describe "GET index" do
    it "returns a successful 200 response" do
       get :index, format: :json
      expect(response).to be_success
    end

    it "returns all the comments" do
      FactoryGirl.create_list(:comment, 5)
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"].length).to eq(5)
    end
  end

  describe "GET show" do
    let(:comment) { FactoryGirl.create(:comment) }

    it "returns a successful 200 response" do
      get :show, params: { id: comment.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["body"]).to eq("Comment body")
    end

    it "returns data of an single comment" do
      get :show, params: { id: comment.id }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]).to_not be_nil
    end

    it "returns an error if the comment does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["response"]).to eq("Comment does not exist")
      expect(response).to be_not_found
    end
  end

  describe "POST create" do
    context "given proper attributes" do
        it "creates a new comment" do
        expect {
          post :create, params: { comments: FactoryGirl.attributes_for(:comment) }
        }.to change(comment, :count).by(1)
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["data"]["body"]).to eq("Comment Body")
      end
    end
  end

  describe "DELETE destroy" do
    let(:comment) { FactoryGirl.create(:comment) }

    it "returns a successful 200 response" do
      delete :destroy, params: { id: comment.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["response"]).to eq("Comment destroyed")
    end

    it "returns an error if the comment does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["response"]).to eq("Comment does not exist")
      expect(response).to be_not_found
    end
  end
end
