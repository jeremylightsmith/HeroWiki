require 'spec_helper'

describe Page do
  before(:each) do
    @valid_attributes = {
      :name => "my name"
    }
    @page = Page.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @page.save!
  end

  describe "validations" do
    it "should be valid w/ valid params" do
      @page.should be_valid
    end
    
    it "should not allow duplicate names" do
      Page.create!(:name => "Alpha Cent", :url => "alpha_cent")
      
      @page.name = "Alpha Cent"
      @page.should have(1).error_on(:name)
    end
    
    it "should not allow duplicate names" do
      Page.create!(:name => "Alpha Cent", :url => "alpha_cent")
      
      @page.url = "alpha_cent"
      @page.should have(1).error_on(:url)
    end
    
    it "should require a name" do
      @page.name = ""
      @page.should have(1).error_on(:name)
    end
    
    it "should create page w/ parent" do
      @page.save!
      p = Page.create!(:name => "alfred", :sidebar => @page)
      p.reload.sidebar.should == @page
    end
  end
  
  describe "name=" do
    it "should default url" do
      @page = Page.new(:name => "Alpha Cent")
      @page.should be_valid
      @page.url.should == "alpha_cent"
    end
    
    it "should handle corner cases" do
      Page.new(:name => "   AlphaBaby  ").url.should == "alphababy"
      Page.new(:name => "some.,\n\tspaces\n\t").url.should == "some_spaces"
    end
  end
  
  describe "body=" do
    it "should create body_html from body" do
      @page.body = "* one\n* two"
      @page.body_html.should == 
"<ul>
\t<li>one</li>
\t<li>two</li>
</ul>"
    end
  end
  
  describe "to_param" do
    it "should use url as to_param" do
      Page.new(:name => "Foo Bar").to_param.should == "foo_bar"
    end
    
    it "should find_by_param" do
      page = Page.create(:name => "Foo Bar")
      Page.find_by_param("foo_bar").should == page
    end
  end
    
  describe "versions" do
    before do
      @user = create_user!
    end
    
    it "should save a version on create" do
      page = Page.create! :name => "World", :author => @user, :body => "Hello"
      page = Page.find(page.id)
      page.body.should == "Hello"
      page.body_html.should == "<p>Hello</p>"
      page.version.should == 1

      version = page.versions.last
      version.body.should == "Hello"
      version.version.should == 1
      version.author.should == @user
    end
    
    it "should save a version on save" do
      page = Page.create! :name => "World", :body => "Hello"
      page.update_attributes! :author => @user, :body => "Goodbye", :version => 1
      page.body.should == "Goodbye"
      page.version.should == 2

      page = Page.find(page.id)
      page.body.should == "Goodbye"
      page.body_html.should == "<p>Goodbye</p>"
      page.version.should == 2

      version = page.versions.last
      version.body.should == "Goodbye"
      version.version.should == 2
      version.author.should == @user
    end
    
    it "should do a soft delete" do
      page = Page.create! :name => "World", :body => "Hello"
      page.soft_delete! @user
                        
      page.reload.deleted_at.should_not be_nil
      page.versions.last.should be_deletion
      page.versions.last.author.should == @user
    end
    
    it "should blow up if we're trying to save the wrong version" do
      page = Page.create! :name => "World", :body => "Hello"
      proc { page.update_attributes! :author => @user, :body => "Goodbye", :version => 2 }.should raise_error(Page::WrongVersion, "This page has been edited since you loaded it (from version 1 -> 2), please copy your changes, refresh the page, and try applying them again")
    end
  end
end
