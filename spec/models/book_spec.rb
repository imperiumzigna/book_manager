# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author      :string           not null
#  cover       :string
#  description :text             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  it "is valid with valid attributes" do
    expect(book).to be_valid
  end

  it "is not valid without a title" do
    book.title = nil
    expect(book).not_to be_valid
  end

  it "is not valid without a description" do
    book.description = nil
    expect(book).not_to be_valid
  end

  it "is not valid without an author" do
    book.author = nil
    expect(book).not_to be_valid
  end
end
