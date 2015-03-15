class LessonsController < ApplicationController
  def index
    @category    = Category.find(params[:category_id])
    #@lessons  = @category.lessons.includes(:entities).all
    @all_lessons = @category.lessons.all
    @lessons     = @all_lessons.paginate(page: params[:page], per_page: 10)
    @lesson      = @category.lessons.new
  end

  def show
    @category = Category.find(params[:category_id])
    @all_lessons = @category.lessons.all
    @lesson      = @all_lessons.find(params[:id])
    @entities = @lesson.entities
  end

  def create
    @category = Category.find(params[:category_id])
    @lesson   = @category.lessons.build(lesson_params)
    if @lesson.save
      respond_to do |format|
        format.html do
          redirect_to [@category, @lesson], notice: 'Lesson created'
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Wrong params for lesson'
          redirect_to category_lessons_path(@category)
        end
      end
    end
  end

  private
    def lesson_params
      params.require(:lesson).permit(:number)
    end
end
