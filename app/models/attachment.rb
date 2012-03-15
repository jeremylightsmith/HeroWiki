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

  def url(*args)
    content.url(*args)
  end

  def thumbnail
    if is_image?
      url(:small)
    else
      "/assets/attachment.png"
    end
  end

  def is_image?
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"].include?(self.content_content_type) 
  end
end
