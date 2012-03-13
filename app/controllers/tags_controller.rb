class TagsController < ApplicationController
  before_filter :load_tag, except:[:index, :create]

  def index
    @tags = Tag.all
  end

  def create
    Tag.create! params[:tag]
    redirect_to tags_path
  end

  def update
    @tag.update_attributes!(params[:tag])
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def load_tag
    @tag = Tag.find(params[:id])
  end

end
