# == Schema Information
#
# Table name: letters
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  dictionary_id :integer
#

class Letter < ActiveRecord::Base
  has_many :entities
  belongs_to :dictionary

  validates :name, presence: true

  validates :dictionary_id, presence: true
end
