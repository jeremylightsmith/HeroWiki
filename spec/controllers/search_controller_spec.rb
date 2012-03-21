require 'spec_helper'

describe SearchController do
  it "should find pages by name" do
    a = Page.create! name:"Apple"
    b = Page.create! name:"Apple Dumpling"
    c = Page.create! name:"Dumpling"

    get :show, :q => "ple"

    assigns(:pages).should == [a,b]
  end
  
  it "should find pages by body" do
    a = Page.create! name:"A", body:"Apple"
    b = Page.create! name:"B", body:"Apple Dumpling"
    c = Page.create! name:"C", body:"Dumpling"

    get :show, :q => "Ple"

    assigns(:pages).should == [a,b]
  end
end
