class TranslateMeGameController < ApplicationController
  def all
    @category = Category.find(params[:id])
    #@lessons  = @category.lessons.includes(:entities)
    @all_lessons = @category.lessons
    @lessons     = @all_lessons.paginate(page: params[:page], per_page: max_entities_per_lesson)
  end

  def translate
    @category = Category.find(params[:id])
    @all_lessons  = @category.lessons
    @lesson = @all_lessons.find_by(number: params[:lesson_number])
    @entities_array = []
    @lesson.entities.each do |e|
      tmp    = []
      tmp[0] = e.word
      tmp[1] = e.translation
      tmp[2] = e.sentence
      tmp[3] = e.tags
      @entities_array << tmp
    end
    # TODO: is @entities_array available in js?
    @entities_array.shuffle!
  end
end
