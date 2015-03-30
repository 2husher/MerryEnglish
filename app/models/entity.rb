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

class Entity < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :part_of_speech
  belongs_to :letter

  has_and_belongs_to_many :labels

  validates :word, presence: true
  validates :translation, presence: true
  validates :sentence, presence: true

  validates :lesson_id, presence: true
  validates :part_of_speech_id, presence: true
  validates :letter_id, presence: true

  default_scope { order('word') }

  def tag!(user, tags)
    tags.split(" ").each do |tag|
      tag = user.tags.where(name: tag).first || user.tags.create(name: tag)
      label = Label.where("user_id = ? and tag_id = ?", user.id, tag.id).first
      self.labels << label unless self.labels.include?(label)
    end
  end

  def untag!(user, tag)
    tag = user.tags.find_by(name: tag)
    if tag.present?
      label = Label.where("user_id = ? and tag_id = ?", user.id, tag.id).first
      self.labels -= [label] if label.present?
    end
  end

  def all_tags(user)
    labels = self.labels.where("user_id = ?", user.id)
    tags = labels.map { |label| label.tag.name }
  end
end
