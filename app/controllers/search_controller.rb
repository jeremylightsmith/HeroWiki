class SearchController < ApplicationController
  def show
    @term = (params[:q] || "").downcase

    @pages = Page.where("lower(name) like ? or lower(body) like ?", "%#{@term}%", "%#{@term}%")
  end
end
