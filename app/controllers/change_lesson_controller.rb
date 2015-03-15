class ChangeLessonController < ApplicationController
  def next
    @category = Category.find(params[:category_id])
    #next_lesson_number = Lesson.find(params[:id]).number.to_i + 1
    next_lesson_number = params[:lesson_number].to_i + 1
    @lesson = @category.lessons.find_by(number: next_lesson_number)

    redirect_to category_lesson_path(@category, @lesson)
  end

  def previous
    @category = Category.find(params[:category_id])
    previous_lesson_number = params[:lesson_number].to_i - 1
    #previous_lesson_number = Lesson.find(params[:id]).number.to_i - 1
    @lesson = @category.lessons.find_by(number: previous_lesson_number)

    redirect_to category_lesson_path(@category, @lesson)
  end
end
