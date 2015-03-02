class LessonsController < ApplicationController
  def all
    @category = Category.find(params[:id])
    @lessons  = @category.lessons.includes(:entities).all
  end

  def show
    @category = Category.find(params[:id])
    @lesson   = @category.lessons.find_by(number: params[:number])
    @lessons  = @category.lessons.includes(:entities).all
    @entities = @lesson.entities
  end
end
