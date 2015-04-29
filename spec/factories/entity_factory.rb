# == Schema Information
#
# Table name: entities
#
#  id                :integer          not null, primary key
#  word              :string
#  translation       :string
#  sentence          :text
#  lesson_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  part_of_speech_id :integer
#  letter_id         :integer
#

FactoryGirl.define do
  factory :entity do
    word "ability"
    translation "способность"
    sentence "His swimming abilities let him cross the entire lake."
  end
end
