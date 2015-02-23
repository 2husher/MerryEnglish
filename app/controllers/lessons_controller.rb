class LessonsController < ApplicationController
  def all
    @lessons = Lesson.includes(:entities).all
  end

  def number
    @lesson   = Lesson.find_by(number: params[:number])
    @entities = @lesson.entities
  end
end
