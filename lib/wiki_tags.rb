module WikiTags
  def pages(options)
    tag_name = options[:text].strip

    pages = if tag_name.present?
              Tag.find_by_name(tag_name).pages.order(:name)
            else
              Page.order(:name)
            end

    html = "<ul class='thumbnails'>\n"

    pages.each do |page|
      html << "  <li class='span2'>\n"
      html << "    <a href='/" << page.url << "' class='thumbnail'>\n"
      html << "      <img src=''/>\n"
      html << "      <h5>" << page.name << "</h5>\n"
      html << "    </a>\n"
      html << "  </li>\n"
    end

    html << "</ul>"
  end
end

