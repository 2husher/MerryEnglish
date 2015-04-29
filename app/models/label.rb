# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_labels_on_tag_id   (tag_id)
#  index_labels_on_user_id  (user_id)
#

class Label < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user

  has_and_belongs_to_many :entities
end
