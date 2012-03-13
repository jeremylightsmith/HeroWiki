module TagsHelper
  def pages_for_tag(tag)
    redcloth = RedCloth.new("pages. #{tag.name}")
    redcloth.extend(WikiTags)
    raw redcloth.to_html(:textile, :refs_wiki_links)
  end
end
