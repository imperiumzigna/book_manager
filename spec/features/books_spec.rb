require "rails_helper"

RSpec.feature "Books", type: :feature, driver: :selenium_chrome, js: true do
  it "show books" do
    visit "/books"
    expect(page).to have_text("Book Manager")
    expect(page).to have_table("books-table")
    expect(page).to have_link("Title")
    expect(page).to have_link("Description")
  end

  it "search a book" do
    books = create_list(:book, 10)

    visit "/books"
    fill_in "q_title_or_description_cont", with: books.first.title
    click_on "commit"
    book_names = page.all("td.").map(&:text)
  end
end
