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
  belongs_to :category

  validates :number, presence: true#, uniqueness: true
  validates :category_id, presence: true
end
