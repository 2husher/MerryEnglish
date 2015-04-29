class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.paginate(page: params[:page], per_page: 20)
  end

  def show
    tag = Tag.find_by(id: params[:id])
    @tag_entities = tag.show_entities(current_user).paginate(page: params[:page], per_page: 20)
  end

  def translate
    @tag = Tag.find_by(id: params[:id])
    @tag_entities = []
    @tag.show_entities(current_user).each do |e|
      tmp    = []
      tmp[0] = e.word
      tmp[1] = e.translation
      tmp[2] = e.sentence
      tmp[3] = e.all_tags(current_user) if current_user.present?
      @tag_entities << tmp
    end
    @tag_entities.shuffle!
  end
end
