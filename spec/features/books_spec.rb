require "rails_helper"

RSpec.feature "Books", type: :feature, driver: :headless_selenium_chrome, js: true do
  include Warden::Test::Helpers
  before(:each) do
    @books = create_list(:book, 50)
  end

  scenario "show books", js: true do
    visit "/books"
    wait_for_ajax
    expect(page).to have_text("Book Manager")
    expect(page).to have_table("books-table")
    expect(page).to have_link("Title")
    expect(page).to have_text("Description")
  end

  scenario "search a book", js: true do
    visit "/books"
    fill_in "q_title_or_description_or_author_cont", with: @books.first.title
    wait_for_ajax
    find("input[name='commit']").click
    within "table" do
      expect(page).to have_text @books.first.title
    end
  end

  scenario "book not found", js: true do
    visit "/books"
    fill_in "q_title_or_description_or_author_cont", with: "akshjasgd"
    wait_for_ajax
    find("input[name='commit']").click
    within "table" do
      expect(page).not_to have_text "akshjasgd"
    end
  end

  scenario "order book by title", js: true do
    visit "/books"
    find("a.sort_link").click
    wait_for_ajax
    first_book = find(".component_title_body_col", match: :first).text
    expect(first_book).to eql(Book.order(title: :desc).first.title)
  end

  scenario "change page", js: true do
    visit "/books"
    find(:xpath, "(//a[text()='2'])").click
    wait_for_ajax
    within "table" do
      expect(page).not_to have_text @books.first.title
    end
  end

  scenario "admin creates a book", js: true do
    login_as FactoryBot.create(:admin), scope: :admin
    visit "/books/new"
    fill_in "book[title]", with: "works"
    fill_in "book[author]", with: "author works"
    fill_in "book[description]", with: "description works"
    fill_in "book[cover]", with: "works"
    find("input[name='commit']").click
    wait_for_ajax

    expect(page.current_path).to eq book_path(Book.last)
    expect(page).to have_text "Book was successfully created"
  end

  scenario "admin update a book", js: true do
    book = @books.last
    login_as FactoryBot.create(:admin), scope: :admin
    visit edit_book_path(book)
    fill_in "book[title]", with: "works"
    fill_in "book[author]", with: "author works"
    fill_in "book[description]", with: "description works"
    fill_in "book[cover]", with: "works"
    find("input[name='commit']").click
    wait_for_ajax

    expect(page.current_path).to eq book_path(Book.last)
    expect(page).to have_text "Book was successfully updated"
  end

  scenario "admin removes a book", js: true do
    login_as FactoryBot.create(:admin), scope: :admin
    visit "/books"
    wait_for_ajax
    find("a.remove-link", match: :first).click
    expect(page).to have_text "Book was successfully destroyed"
  end
end
