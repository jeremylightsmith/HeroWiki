require 'spec_helper'

describe Version do
  let (:page) { Page.create! name:"foo", body:"Hello, Bob\nGood Day" }
  let (:version) { page.versions.last }

  it "should know previous version" do
    page.body = "new stuff"
    page.save!

    page.versions.last.previous.should == page.versions.first
    page.versions.first.previous.should == nil
  end
  
  it "should know diff" do
    page.body = "Hello, Bob\nGood Bye"
    page.save!

    page.versions.first.diff.should == "<ins class=\"differ\">Hello, Bob\nGood Day</ins>"
    page.versions.last.diff.should == "Hello, Bob\n<del class=\"differ\">Good Day</del><ins class=\"differ\">Good Bye</ins>"
  end

  it "should show diff for same" do
    page.body = "Hello, Bob\nGood Day"
    page.save!

    page.versions.count.should == 1
    page.versions.first.diff.should == "<ins class=\"differ\">Hello, Bob\nGood Day</ins>"
  end
end
