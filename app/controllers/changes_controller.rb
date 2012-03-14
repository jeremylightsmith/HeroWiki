class ChangesController < ApplicationController
  def index
    @changes = Version.order("created_at desc").paginate(:page => params[:page])
  end
end
