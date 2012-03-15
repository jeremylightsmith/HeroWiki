class Pages::AttachmentsController < ApplicationController
  before_filter :require_editor!
  before_filter :load_page

  def create
    @page.attachments.create! params[:attachment]
    redirect_to @page
  end

  def destroy
    @page.attachments.find(params[:id]).destroy
    redirect_to [@page, :attachments]
  end

  protected

  def load_page
    @page = Page.find_by_url(params[:page_id])
  end
end
