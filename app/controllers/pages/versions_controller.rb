class Pages::VersionsController < ApplicationController
  before_filter :require_editor!
  before_filter :load_page
  
  def index
    @versions = @page.versions.order("created_at desc")
  end
  
  def show
    @version = @page.versions.find_by_version(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
  
  protected
  
  def load_page
    @page = Page.find_by_param(params[:page_id]) || raise(ActiveRecord::RecordNotFound)
  end
end
