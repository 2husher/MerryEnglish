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

  def show_entities(user)
    label = Label.where("user_id = ? and tag_id = ?", user.id, self.id).first
    label.entities
  end
end
