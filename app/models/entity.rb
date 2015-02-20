# == Schema Information
#
# Table name: entities
#
#  id                :integer          not null, primary key
#  word              :string
#  translation       :string
#  sentence          :text
#  dictionary_id     :integer
#  lesson_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  part_of_speech_id :integer
#

class Entity < ActiveRecord::Base
  belongs_to :dictionary
  belongs_to :lesson
  belongs_to :part_of_speech

  validates :word, presence: true
  validates :translation, presence: true
  validates :sentence, presence: true
  validates :dictionary, presence: true

  validates :dictionary_id, presence: true
  validates :lesson_id, presence: true
  validates :part_of_speech_id, presence: true
end
