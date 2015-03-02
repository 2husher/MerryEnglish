class DictionaryController < ApplicationController
  def all
    @category = Category.find(params[:id])
    @entities = @category.entities.includes(:part_of_speech)
  end

  def letter
    begin
      @category = Category.find(params[:id])
      @letter   = Letter.find_by(name: params[:letter])
      @entities = @category.entities.where("letter_id = ?", @letter)
    rescue Exception => e
      redirect_to 'root'
    end
  end

  def part_of_speech
    begin
      @category       = Category.find(params[:id])
      @part_of_speech = PartOfSpeech.find_by(name: params[:part_of_speech])
      @entities       = @category.entities.where("part_of_speech_id = ?", @part_of_speech)
    rescue Exception => e
      redirect_to root_path
    end
  end

  def all_words
    @entities = Entity.includes(:part_of_speech).all
  end

  def all_letters
    @letter   = Letter.find_by(name: params[:letter])
    @entities = @letter.entities.all
    render 'letter'
  end

  def all_part_of_speech
    @part_of_speech = PartOfSpeech.find_by(name: params[:part_of_speech])
    @entities       = @part_of_speech.entities
  end
end
