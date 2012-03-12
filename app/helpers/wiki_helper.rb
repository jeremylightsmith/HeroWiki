module WikiHelper
  def available_page_actions(page)
    return nil unless can_edit?
    
    raw [
      link_to("[edit]", edit_wiki_path(page), :class => 'edit_page page-action'),
      link_to("[x]", wiki_path(page), :method => :delete, :confirm => "Are you sure you want to delete this page?", :class => "page-action")
    ].join(' ')
  end

  def sidebar_title(sidebar)
    title = sidebar.name
    title.gsub!(/ ?Sidebar/, '')
    title << " " << link_to("[edit]", edit_page_path(sidebar)) if can_edit?
    raw title
  end
end
