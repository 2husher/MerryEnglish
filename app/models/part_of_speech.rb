# == Schema Information
#
# Table name: part_of_speeches
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  acronym    :string
#

class PartOfSpeech < ActiveRecord::Base
  has_many :entities

  validates :name, presence: true
  validates :acronym, presence: true
end
