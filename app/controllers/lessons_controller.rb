class LessonsController < ApplicationController
  def all
    @lessons = Lesson.all
  end

  def number
    @lesson   = Lesson.find_by(number: params[:number])
    @entities = @lesson.entities
  end
end
