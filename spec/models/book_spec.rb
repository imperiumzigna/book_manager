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
require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
