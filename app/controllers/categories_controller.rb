class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @new_category = Category.new
  end
end
