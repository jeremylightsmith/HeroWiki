module Paperclip
  class Padder < Thumbnail
    def transformation_command
      super + ["-gravity center",
               "-background white",
               "-extent", %["#{geometry_extent}"]]
    end

    def geometry_extent
      "#{target_geometry.width.to_i}x#{target_geometry.height.to_i}"
    end
  end
end

