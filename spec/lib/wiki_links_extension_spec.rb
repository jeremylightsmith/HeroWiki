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

  it "should show a missing wiki name for a page that doesn't exist" do
    RedCloth.new("some [Missing] stuff").to_html(:textile, :refs_wiki_links).should == <<-HTML.chomp
<p>some <a href='/wiki/new?page[name]=Missing' class='missing-wiki-link'>[Missing?]</a> stuff</p>
    HTML
  end
  
end
