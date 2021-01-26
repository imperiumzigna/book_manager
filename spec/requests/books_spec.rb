require "rails_helper"

RSpec.describe "Books", type: :request do
  let(:books) { create_list(:book, 50) }
  describe "GET /books" do
    it "loads path" do
      get books_index_path
      expect(response).to have_http_status(200)
    end
  end
end
