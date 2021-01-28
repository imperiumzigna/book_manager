require "rails_helper"

RSpec.describe "Books", type: :request do
  let(:books) { create_list(:book, 50) }
  describe "GET /books" do
    it "loads path" do
      get books_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get book_url(books.first)
      expect(response).to be_successful
    end
  end
end
