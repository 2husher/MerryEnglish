# == Schema Information
#
# Table name: dictionaries
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dictionary < ActiveRecord::Base
  has_many :letters
  has_many :entities, through: :letters
end
