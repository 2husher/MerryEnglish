# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
  has_many :entities

  validates :number, presence: true
end
