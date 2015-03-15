class EntitiesController < ApplicationController
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @new_entity   = @lesson.entities.build(entity_params)
    word = params[:entity][:word]
    letter = word[0].upcase if word
    @new_entity.letter = Letter.find_by(name: letter)
    @new_entity.part_of_speech = PartOfSpeech.find_by(name: params[:pos][:part_of_speech])
    if @new_entity.save!
      respond_to do |format|
        format.html do
          redirect_to [@lesson.category, @lesson], notice: 'Lesson created'
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Wrong params for entity'
          redirect_to category_lesson_path(@lesson.category, @lesson)
        end
      end
    end
  end

  private
    def entity_params
      params.require(:entity).permit(:word, :translation, :part_of_speech_id, :sentence)
    end
end
