class Attachment < ActiveRecord::Base
  belongs_to :page

  has_attached_file :content, 
                    STORAGE_OPTIONS.merge(
                      styles: {
                        tiny:"160x120#",
                        small:"260x180#",
                        medium:"360x268#",
                        large:"570x416#",
                      }, 
                      default_url:"/assets/missing_:style.png"
                    )
  before_post_process :is_image?

  protected

  def is_image?
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.asset_content_type) 
  end
end
