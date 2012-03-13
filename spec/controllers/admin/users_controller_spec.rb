require 'spec_helper'

describe Admin::UsersController, "without logging in" do
  it "should require admin login" do
    bob = create_user!
    sign_in bob
    get :index
    
    response.should redirect_to("/")
  end

  it "should require login" do
    get :index
    
    response.should redirect_to(sign_in_path)
  end
end

describe Admin::UsersController do
  before do
    @admin = create_admin!
    @bob = create_user!(:email => "bob@foo.com")
    @jack = create_user!(:email => "jack@foo.com")

    sign_in @admin
  end

  it "should show users" do
    get :index
    
    response.should be_success
    assigns(:users).should include(@admin)
    assigns(:users).should include(@bob)
    assigns(:users).should include(@jack)
  end
  
  it "should update all user attributes" do
    get :update, :id => @bob.id, :user => {:name => 'george', :admin => true}
    
    @bob.reload.name.should == 'george'
    @bob.admin?.should == true
  end
  
  it "should destroy a user" do
    delete :destroy, :id => @bob.id
    
    response.should redirect_to(admin_users_path)
    User.exists?(@bob.id).should be_false
  end
end
