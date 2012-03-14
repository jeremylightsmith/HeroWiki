require 'spec_helper'

describe WikiTags do
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
