class PagesController < ApplicationController
  before_filter :require_editor!, :except => [:home, :show, :index]
  before_filter :load_page, :except => [:show, :new, :index, :create, :home]
  before_filter :forget_all_html, :only => [:create, :destroy, :update]
  
  protect_from_forgery :except => [:preview]
  
  def show
    @page = Page.find_by_param(params[:id])
    
    if @page
      @html = html_for_page(@page)
      render
    elsif can_edit?
      @page = Page.new(:name => params[:id].titleize)
      render :action => :new
    else
      render :action => "not_found"
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
    @page = Page.new(params[:page].merge(:author => current_user))
    if @page.save
      redirect_to(page_path(@page))
    else
      render :new
    end
  end
  
  def update
    if @page.update_attributes(params[:page].merge(:author => current_user))
      redirect_to(page_path(@page))
    else
      render :edit
    end

  rescue Page::WrongVersion
    flash.now[:alert] = "This page has been edited since you loaded it, please copy your changes, refresh it, and try applying them again"
    render :action => :edit 
  end
  
  def destroy
    @page.destroy
    #@page.soft_delete! current_user
    redirect_to(pages_path)
  end

  def home
    @page = Page.find_by_name("Home") || redirect_to("/pages/home")
    @html = html_for_page(@page)
  end
  
  protected 
  
  def forget_all_html
    Rails.cache.clear
  end

  def html_for_page(page)
    Rails.cache.fetch("/pages/#{page.url}") do
      page.body_html
    end
  end
  
  def load_page
    @page = Page.find_by_param(params[:id]) || raise(ActiveRecord::RecordNotFound)
  end
end
