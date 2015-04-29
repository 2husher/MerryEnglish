# == Schema Information
#
# Table name: letters
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Letter < ActiveRecord::Base
  has_many :entities

  validates :name, presence: true
end
