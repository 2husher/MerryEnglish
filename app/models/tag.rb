# == Schema Information
#
# Table name: tags
#
#  id   :integer          not null, primary key
#  name :string
#

class Tag < ActiveRecord::Base
  has_many :labels
  has_many :users, through: :labels

  validates :name, presence: true
end
