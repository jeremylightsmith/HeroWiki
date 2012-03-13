require 'spec_helper'

describe WikiController do  
  let(:page) {Page.create!(:name => "Foo Bar")}

  describe "routes" do
    it "should have default page path" do
      {:get => "/wiki/about_us"}.should route_to(:controller => "wiki", :action => "show", :id => "about_us")
    end
  
    it "should have index page" do
      {:get => "/wiki"}.should route_to(:controller => "wiki", :action => "index")
    end
    
    it "should have create page" do
      {:post => "/wiki"}.should route_to(:controller => "wiki", :action => "create")
    end
    
    it "should have simple put page" do
      {:put => "/wiki/about_us"}.should route_to(:controller => "wiki", :action => "update", :id => "about_us")
    end
    
    it "should have simple delete page" do
      {:delete => "/wiki/about_us"}.should route_to(:controller => "wiki", :action => "destroy", :id => "about_us")
    end
  end
  
  describe "GET show" do
    render_views
    
    context "when an admin is logged in" do
      as_editor
    
      it "should display a page by url" do
        page.update_attribute(:body, "foo bar html")

        get :show, :id => page.to_param
      
        assigns(:page).should == page
        response.should be_success
        response.body.should =~ /\<html/
        response.body.should include("foo bar html")
      end
      
      it "should redirect to new page if the page you are looking for doesn't exist" do
        get :show, :id => "some_little_thing"
        
        assigns(:page).name.should == "Some Little Thing"
        assigns(:page).should be_new_record
        response.should render_template(:new)
      end
    end
    
    context "when an admin is NOT logged in" do
      it "should show pages" do
        get :show, :id => page.to_param
      
        response.should be_success
      end
      
      it "should throw 404 if page & template doesn't exist" do
        get :show, :id => "asdf"
      
        response.should render_template("/not_found")
      end
    end
  end
  
  describe "GET index" do
    it "should get all pages" do
      @page1, @page2 = Page.create!(:name => "one"), Page.create!(:name => "two")
      
      get :index
      
      response.should be_success
      assigns(:pages).should include(@page1)
      assigns(:pages).should include(@page2)
    end
  end
  
  describe "GET new" do
    as_editor

    it "should show new page page" do
      get :new
      
      response.should be_success
      assigns(:page).should be_new_record
    end
  end
  
  describe "GET edit" do
    as_editor
    
    it "should show new page page" do
      get :edit, :id => page.to_param
      
      response.should be_success
      assigns(:page).should == page
    end
    
    it "should throw 404 if page doesn't exist" do
      proc { get :edit, :id => "asdf" }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
  
  describe "POST create" do
    as_editor
    
    it "should create a page" do
      post :create, :page => {:name => "foo", :body => "crap"}
      
      page = assigns(:page)
      page.should_not be_new_record
      page.name.should == "foo"
      page.url.should == "foo"
      page.body.should == "crap"
      response.should redirect_to(wiki_path(page))
    end
  end
  
  describe "PUT update" do
    as_editor
    
    it "should update a page" do
      put :update, :id => page.to_param, :page => {:name => "foo", :body => "crap"}
      
      response.should redirect_to(wiki_path(page.reload))
      assigns(:page).should == page
      page.name.should == "foo"
      page.url.should == "foo"
      page.body.should == "crap"
    end
    
    it "should tell the user if a conflict happens" do
      put :update, :id => page.to_param, :page => {:name => "foo", :body => "crap", :version => "3"}
      
      response.should be_success
    end
  end
  
  describe "DELETE destroy" do
    as_editor
    
    it "should destroy" do
      delete :destroy, :id => page.to_param
      
      response.should redirect_to("/wiki")
      Page.exists?(page).should == false
      #page.reload.deleted_at.should_not be_nil
    end
  end
end
