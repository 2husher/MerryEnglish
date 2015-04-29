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

FactoryGirl.define do
  factory :lesson do
    number 1
  end
end
