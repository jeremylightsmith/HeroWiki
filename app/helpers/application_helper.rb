module ApplicationHelper
  def page(options)
    @page_title = options[:title]
    @page_subtitle = options[:subtitle]
    @page_class = options[:class]
    @page_parent = options[:parent].is_a?(Array) ? options[:parent] : [options[:parent]]
  end

  def subtitle(sub)
    @page_subtitle = sub
  end

  def nav_link(name, url)
    content_tag :li, link_to(name, url), class:(current_page?(url) ? "active" : nil)
  end
end
