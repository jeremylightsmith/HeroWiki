require 'spec_helper'

describe SessionsController do
  let(:editor) { create_editor! name:"Bob", provider:"google", uid:"123" }
  let(:user) { create_user! name:"Bob2", provider:"google", uid:"123" }

  it "should create a session for an editor" do
    editor

    request.env["omniauth.auth"] = {
      provider:"google", uid:"123", info:{email:"bob@example.com"}
    }

    post :create

    response.should redirect_to(root_path)
    flash[:notice].should == "Welcome back, Bob"
  end

  it "should create a session for a new user" do
    user 

    request.env["omniauth.auth"] = {
      provider:"google", uid:"123", info:{email:"bob@example.com"}
    }

    post :create

    response.should redirect_to("/welcome")
    flash[:notice].should == "Welcome, Bob2"
  end

  it "should give someone edit access if they know the password" do
    sign_in user

    post :unlock, password:"food and stuff"

    response.should redirect_to("/")
    user.reload.should be_editor
  end
end
