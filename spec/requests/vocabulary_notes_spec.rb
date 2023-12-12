require 'rails_helper'

RSpec.describe "VocabularyNotes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/vocabulary_notes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/vocabulary_notes/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/vocabulary_notes/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/vocabulary_notes/create"
      expect(response).to have_http_status(:success)
    end
  end

end
