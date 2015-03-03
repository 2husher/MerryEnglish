class ChangeTranslateMeController < ApplicationController
  def next
    @category = Category.find(params[:category_id])
    next_lesson_number = params[:lesson_number].to_i + 1
    @lesson = @category.lessons.find_by(number: next_lesson_number)

    redirect_to translate_me_category_path(@category, @lesson.number)
  end

  def previous
    @category = Category.find(params[:category_id])
    previous_lesson_number = params[:lesson_number].to_i - 1
    @lesson = @category.lessons.find_by(number: previous_lesson_number)

    redirect_to translate_me_category_path(@category, @lesson.number)
  end
end
