class TranslateMeGameController < ApplicationController
  def all
    @lessons = Lesson.includes(:entities).all
  end

  def translate
    @lesson = Lesson.find_by(number: params[:lesson_number])
    @entities_array = []
    @lesson.entities.each do |e|
      tmp = []
      tmp[0] = e.word
      tmp[1] = e.translation
      tmp[2] = e.sentence
      @entities_array << tmp
    end
    # TODO: is @entities_array available in js?
    @entities_array.shuffle!
  end
end
