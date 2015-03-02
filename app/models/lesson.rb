# == Schema Information
#
# Table name: lessons
#
#  id          :integer          not null, primary key
#  number      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#

class Lesson < ActiveRecord::Base
  has_many :entities

  validates :number, presence: true, uniqueness: true
end
