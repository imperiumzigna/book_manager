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
class Book < ApplicationRecord
  validates_presence_of :author, :title, :description
end
