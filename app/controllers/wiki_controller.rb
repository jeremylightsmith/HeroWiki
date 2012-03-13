class WikiController < ApplicationController
  #before_filter :authenticate_user!, :internal_required, :except => [:show]
  before_filter :load_page, :except => [:show, :new, :index, :create, :home]
  
  protect_from_forgery :except => [:preview]
  
  def show
    @page = Page.find_by_param(params[:id])
    
    if @page
      render
    elsif can_edit?
      @page = Page.new(:name => params[:id].titleize)
      render :action => :new
    else
      raise ActiveRecord::RecordNotFound
    end
  end
  
  def new
    @page = Page.new(params[:page])
  end
  
  def edit
  end
  
  def index
    @pages = Page.find(:all, :order => :name)
  end
  
  def create
    @page = Page.create!(params[:page].merge(:author => current_user))
    redirect_to(wiki_path(@page))
  end
  
  def update
    @page.update_attributes!(params[:page].merge(:author => current_user))
    redirect_to(wiki_path(@page))
  rescue Page::WrongVersion
    flash.now[:alert] = "This page has been edited since you loaded it, please copy your changes, refresh it, and try applying them again"
    render :action => :edit 
  end
  
  def destroy
    @page.soft_delete! current_user
    redirect_to(wiki_path)
  end

  def home
    @page = Page.find_by_name("Home") || redirect_to("/wiki/home")
  end
  
  protected 
  
  def load_page
    @page = Page.find_by_param(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
