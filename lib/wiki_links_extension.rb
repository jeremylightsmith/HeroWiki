module WikiLinksExtension
  include Rails.application.routes.url_helpers

  def page_url_for_name(name)
    page = Page.find_by_name(name)
    page ? page.url : nil
  end
  
  def refs_wiki_links(text)
    text.gsub!(/\[([A-Za-z0-9 _+-]+)\]/) do |m|
      name = $1
      if url = page_url_for_name(name)
        "<a href='/#{url}' class='wiki-link'>[#{name}]</a>"
      else
        "<a href='/pages/new?page[name]=#{name}' class='missing-wiki-link'>[#{name}?]</a>"
      end
    end
  end
end

RedCloth.send(:include, WikiLinksExtension)

