class LessonsController < ApplicationController
  def all
    @category    = Category.find(params[:id])
    #@lessons  = @category.lessons.includes(:entities).all
    @all_lessons = @category.lessons
    @lessons     = @all_lessons.paginate(page: params[:page], per_page: 10)
  end

  def show
    @category = Category.find(params[:id])
    @all_lessons = @category.lessons
    @lesson      = @all_lessons.find_by(number: params[:number])
    @entities = @lesson.entities
  end
end
