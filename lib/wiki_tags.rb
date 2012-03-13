module WikiTags
  def pages(options)
    html = "<ul class='thumbnails'>\n"

    Page.order(:name).each do |page|
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

