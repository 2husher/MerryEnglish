class TranslateMeGameController < ApplicationController
  def all
    @category = Category.find(params[:id])
    @lessons  = @category.lessons.includes(:entities).all
  end

  def translate
    @category = Category.find(params[:id])
    @lessons  = @category.lessons.includes(:entities).all
    @lesson = @category.lessons.find_by(number: params[:lesson_number])
    @entities_array = []
    @lesson.entities.each do |e|
      tmp    = []
      tmp[0] = e.word
      tmp[1] = e.translation
      tmp[2] = e.sentence
      @entities_array << tmp
    end
    # TODO: is @entities_array available in js?
    @entities_array.shuffle!
  end
end
