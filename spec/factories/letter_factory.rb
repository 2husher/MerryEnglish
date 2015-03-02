# == Schema Information
#
# Table name: letters
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :letter do
    name "A"
  end
end
