require 'rails_helper'

RSpec.describe Api::V1::LinksController do
  describe "GET index" do
    it "returns a successful 200 response" do
       get :index, format: :json
      expect(response).to be_success
    end

    it "returns all the links" do
      FactoryGirl.create_list(:link, 5)
      get :index, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"].length).to eq(5)
    end
  end

  describe "GET show" do
    let(:link) { FactoryGirl.create(:link) }

    it "returns a successful 200 response" do
      get :show, params: { id: link.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["url"]).to eq("test_url")
    end

    it "returns data of an single link" do
      get :show, params: { id: link.id }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]).to_not be_nil
    end

    it "returns an error if the link does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['response']).to eq("Link does not exist")
      expect(response).to be_not_found
    end
  end

  describe "POST create" do
    context "given proper attributes" do
        it "creates a new link" do
        expect {
          post :create, params: { links: FactoryGirl.attributes_for(:link) }
        }.to change(Link, :count).by(1)
        expect(response).to be_success
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["data"]["url"]).to eq("test_url")
      end
    end
  end

  describe "DELETE destroy" do
    let(:link) { FactoryGirl.create(:link) }

    it "returns a successful 200 response" do
      delete :destroy, params: { id: link.id }, format: :json
      expect(response).to be_success
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['response']).to eq("Link destroyed")
    end

    it "returns an error if the link does not exist" do
      get :show, params: { id: 1000000 }, format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['response']).to eq("Link does not exist")
      expect(response).to be_not_found
    end
  end
end
