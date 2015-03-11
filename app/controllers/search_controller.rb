class SearchController < ApplicationController
  def find_words
    @found_entities = Entity.where('word LIKE ?', "%#{params[:search]}%")
  end
end
