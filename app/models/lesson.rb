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

class Lesson < ActiveRecord::Base
  attr_accessor :bundle

  has_many :entities
  belongs_to :category

  validates :number, presence: true#, uniqueness: true
  validates :category_id, presence: true

  def entity_attributes=(entity_attributes)
    p "HEEEEEEEEEERRRRRRRRRRRREEEEEEEEEEEE"
    entity_attributes.each do |attributes|
      part_of_speech = PartOfSpeech.find_by(acronym: attributes[:part_of_speech])
      p part_of_speech
      attributes.merge!(part_of_speech: part_of_speech)
      p attributes
      p "PartOfSpeech #{attributes[:part_of_speech]}"
      new_entity = entities.build(attributes)
      word = attributes[:word]
      letter = word[0].upcase if word.present?
      new_entity.letter = Letter.find_by(name: letter)
      new_entity.save!
    end
  end
end
