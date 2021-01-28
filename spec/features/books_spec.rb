require "rails_helper"

RSpec.feature "Books", type: :feature, driver: :chrome_headless, js: true do
  before(:all) do
    @books = create_list(:book, 10)
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
    wait_for_ajax
    find("a.sort_link").click
    first_book = find(".component_title_body_col", match: :first).text
    expect(first_book).to eql(Book.order(:title).first.title)
  end

  scenario "change page", js: true do
    visit "/books"
    find(:xpath, "(//a[text()='2'])").click
    wait_for_ajax
    within "table" do
      expect(page).not_to have_text Book.first.title
    end
  end
end
