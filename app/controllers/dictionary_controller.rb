class DictionaryController < ApplicationController
  def index
    d         = Dictionary.find(1)
    # without includes(:part_of_speech) a lot of CACHE
    @entities = d.entities.includes(:part_of_speech).all
  end

  def letter
    begin
      d         = Dictionary.find(1)
      @letter   = d.letters.find_by(name: params[:letter])
      @entities = @letter.entities
    rescue Exception => e
      redirect_to 'root'
    end
  end

  def part_of_speech
    begin
      #d              = Dictionary.find(1)
      @part_of_speech = PartOfSpeech.find_by(name: params[:part_of_speech])
      @entities       = @part_of_speech.entities
    rescue Exception => e
      redirect_to root_path
    end
  end
end
