class DictionaryController < ApplicationController
  def index
    d         = Dictionary.find(1)
    @entities = d.entities.all
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
end
