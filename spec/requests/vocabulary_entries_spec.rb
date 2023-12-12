require 'rails_helper'

RSpec.describe "VocabularyEntries", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/vocabulary_entries/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/vocabulary_entries/create"
      expect(response).to have_http_status(:success)
    end
  end

end
