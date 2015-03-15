class LessonsController < ApplicationController
  def index
    @category    = Category.find(params[:category_id])
    #@lessons  = @category.lessons.includes(:entities).all
    @all_lessons = @category.lessons.all
    @lessons     = @all_lessons.paginate(page: params[:page], per_page: 10)
  end

  def show
    @category = Category.find(params[:category_id])
    @all_lessons = @category.lessons
    @lesson      = @all_lessons.find(params[:id])
    @entities = @lesson.entities
  end
end
