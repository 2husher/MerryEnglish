class LessonsController < ApplicationController
  def index
    @category    = Category.find(params[:category_id])
    #@lessons  = @category.lessons.includes(:entities).all
    @all_lessons = @category.lessons.all
    @lessons     = @all_lessons.paginate(page: params[:page], per_page: max_entities_per_lesson)
    @new_lesson      = @category.lessons.new
  end

  def show
    @category = Category.find(params[:category_id])
    @all_lessons = @category.lessons.all
    @lesson      = @all_lessons.find(params[:id])
    # without all @entities processed at form and include nill new entity
    @entities = @lesson.entities.all
    @new_lesson      = @category.lessons.new
    @new_entity      = @entities.new
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

  def update
    @category = Category.find(params[:category_id])
    @lesson   = @category.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to [@category, @lesson]
    end
  end

  def create_bundle
    @category = Category.find(params[:category_id])
    @lesson   = @category.lessons.find(params[:id])
    @all_lessons = @category.lessons.all
    @new_lesson      = @category.lessons.new
    bundle = params[:lesson][:bundle]
    p bundle
    bundle_split = bundle.split(/(.+)\s+\[(\w+)\]\s+(.+)\s+\[.*\]\s+(.+)\n/)
    @entities = []
    bundle_split.each_slice(5) do |x|
      entity = {}
      entity[:translation] = x[1]
      entity[:pos] = x[2]
      entity[:word] = x[3]
      entity[:sentence] = x[4]
      letter = entity[:word].upcase if entity[:word].present?
      entity[:letter] = Letter.find_by(name: letter)
      @entities << entity
    end
    @entities.size.times{ @lesson.entities.build }
  end

  def continue_create_bundle
  end

  private
    def lesson_params
      params.require(:lesson).permit(:number, entity_attributes: [:word, :translation, :sentence, :part_of_speech])
    end
end
