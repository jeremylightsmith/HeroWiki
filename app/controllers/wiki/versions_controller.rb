class Wiki::VersionsController < ApplicationController
  before_filter :authenticate_user!, :internal_required
  before_filter :load_page
  
  def index
    @versions = @page.versions.order("created_at desc")
  end
  
  def show
    @version = @page.versions.find_by_version(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
  
  protected
  
  def load_page
    @page = Page.find_by_param(params[:wiki_id]) || raise(ActiveRecord::RecordNotFound)
  end
end