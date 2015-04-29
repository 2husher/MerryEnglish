class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @new_category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.html do
          redirect_to dictionary_all_category_path(@category), notice: 'Lesson created'
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Wrong params for category'
          redirect_to root_path
        end
      end
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
