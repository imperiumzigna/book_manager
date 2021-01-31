require "rails_helper"

RSpec.describe BooksController, type: :controller do
  context "unauthenticated user" do
    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_successful
      end
      it "returns a success response changing page" do
        get :index, params: { page: 2 }
        expect(response).to be_successful
      end

      it "returns a success response visiting a book profile" do
        book = create(:book)
        get :show, params: { id: book.id }
        expect(response).to be_successful
      end

      it "returns a redirect response visiting on book not found" do
        get :show, params: { id: 29834729837 }
        expect(response).to have_http_status(302)
      end
    end
  end

  context "admin user" do
    login_admin
    it "create a valid book" do
      post :create, params: { book: FactoryBot.build(:book).as_json }
      expect(response).to have_http_status(302)
    end

    it "update book" do
      book = create(:book)
      post :update, params: { id: book.id, book: { title: "something" } }
      expect(response).to have_http_status(302)
      expect("something").to eql(book.reload.title)
    end

    it "destroy book" do
      book_id = create(:book).id
      delete :destroy, params: { id: book_id }
      expect(response).to have_http_status(302)
      expect { Book.find(book_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
