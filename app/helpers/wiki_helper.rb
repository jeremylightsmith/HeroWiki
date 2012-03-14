module WikiHelper
  def wiki_path(page)
    "/#{page.url}"
  end

  def available_page_actions(page)
    return nil unless can_edit?
    
    raw link_to("Edit", edit_wiki_path(page))
  end

  def tag_selector(tag, selected)
    css = "tag label"
    css << " label-info" if selected
    link_to tag.name, "#", class:css, tagId:tag.id
  end

  def tags_for_page(page)
    html = []
    page.tags.each do |tag|
      html << link_to(tag.name, tag, :class => "label label-info")
    end
    html.join(" ")
  end

  def sidebar_title(sidebar)
    title = sidebar.name
    title.gsub!(/ ?Sidebar/, '')
    title << " " << link_to("[edit]", edit_page_path(sidebar)) if can_edit?
    raw title
  end
end
