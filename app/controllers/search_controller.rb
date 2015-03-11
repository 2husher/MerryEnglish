class SearchController < ApplicationController
  autocomplete :entity, :word

  def find_words
    search = params[:search]
    if search.present?
      @found_entities = Entity.where('word LIKE ?', "%#{search}%")
    else
      redirect_to :back, alert: 'Empty search'
    end
  end
end
