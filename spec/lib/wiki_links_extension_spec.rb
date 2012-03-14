require 'spec_helper'

describe WikiLinksExtension do
  it "should parse regular redcloth" do
    RedCloth.new("h1. hello").to_html.should == <<-HTML.chomp
<h1>hello</h1>
    HTML
  end

  it "should parse a wiki name for a page that exists" do
    page = Page.create!(name:"Foo Bar")

    RedCloth.new("some [Foo Bar] stuff").to_html(:textile, :refs_wiki_links).should == <<-HTML.chomp
<p>some <a href='/foo_bar' class='wiki-link'>[Foo Bar]</a> stuff</p>
    HTML
  end

  it "should catch weird names" do
    RedCloth.new("[a_-+ s]").to_html(:textile, :refs_wiki_links).should include("wiki-link'>[a_-+ s?]</")
  end

  it "should show a missing wiki name for a page that doesn't exist" do
    RedCloth.new("some [Missing] stuff").to_html(:textile, :refs_wiki_links).should == <<-HTML.chomp
<p>some <a href='/wiki/new?page[name]=Missing' class='missing-wiki-link'>[Missing?]</a> stuff</p>
    HTML
  end
  
  it "should show a wall of pages" do
    Page.create! name:"Apple"
    Page.create! name:"Banana"

    redcloth = RedCloth.new("pages. ")
    redcloth.extend(WikiTags)
    redcloth.to_html.should == <<-HTML.chomp
<ul class='thumbnails'>
  <li class='span3'>
    <a href='/apple' class='thumbnail'>
      <h5>Apple</h5>
    </a>
  </li>
  <li class='span3'>
    <a href='/banana' class='thumbnail'>
      <h5>Banana</h5>
    </a>
  </li>
</ul>
    HTML
  end
  
  it "should only show pages for given tag" do
    apple, banana, lemon = %w(apple banana lemon).map{|n| Page.create! name:n}
    tag = Tag.create! name:"breakfast"
    tag.pages << apple << banana

    redcloth = RedCloth.new("pages. breakfast")
    redcloth.extend(WikiTags)
    html = redcloth.to_html
    html.should include("apple")
    html.should include("banana")
    html.should_not include("lemon")
  end
end
