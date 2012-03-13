require 'spec_helper'

describe Tag do
  it "should be able to be associated to a page" do
    tag = Tag.create! name:"Foo"

    page = Page.create! name:"Page1"

    page.tags << tag
    tag.reload.pages.should == [page]
  end
end
