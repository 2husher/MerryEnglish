class DictionaryController < ApplicationController
  def all
    @category = Category.find(params[:id])
    #@entities = @category.entities.includes(:part_of_speech)
    @entities = @category.entities.paginate(page: params[:page], per_page: max_entities_per_lesson)
  end

  def letter
    begin
      @category = Category.find(params[:id])
      @letter   = Letter.find_by(name: params[:letter])
      @entities = @category.entities.where("letter_id = ?", @letter)
                  .paginate(page: params[:page], per_page: max_entities_per_lesson)
    rescue Exception => e
      redirect_to 'root'
    end
  end

  def part_of_speech
    begin
      @category       = Category.find(params[:id])
      @part_of_speech = PartOfSpeech.find_by(name: params[:part_of_speech])
      @entities       = @category.entities.where("part_of_speech_id = ?", @part_of_speech)
                        .paginate(page: params[:page], per_page: max_entities_per_lesson)
    rescue Exception => e
      redirect_to root_path
    end
  end

  def all_words
    #@entities = Entity.includes(:part_of_speech).all
    @entities = Entity.paginate(page: params[:page], per_page: max_entities_per_lesson)
  end

  def all_letters
    @letter   = Letter.find_by(name: params[:letter])
    @entities = @letter.entities.paginate(page: params[:page], per_page: max_entities_per_lesson)
    render 'letter'
  end

  def all_part_of_speech
    @part_of_speech = PartOfSpeech.find_by(name: params[:part_of_speech])
    @entities       = @part_of_speech.entities.paginate(page: params[:page], per_page: max_entities_per_lesson)
  end

  def word
    @entity = Entity.find_by(word: params[:word])
  end

  def unknown
    lesson = Lesson.find_by(id: params[:lesson_id])
    entity = lesson.entities.find_by(word: params[:word])
    tags = 'UNKNOWN'
    entity.tag!(tags)
    render nothing: true
  end
end
