require 'spec_helper'

describe Admin::UsersController, "without logging in" do
  it "should require admin login" do
    bob = create_user!
    sign_in bob
    get :index
    
    response.should render_template("must_be_admin")
  end

  it "should require login" do
    get :index
    
    response.should redirect_to(new_user_session_path)
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
  
  it "should create a user" do
    get :create, :user => {:name => 'george', :email => 'george@jungle.com', :password => 'jungle', :password_confirmation => 'jungle'}
    
    assigns(:user).name.should == 'george'
    assigns(:user).should be_valid_password("jungle")
  end
  
  it "should update user, and not change pass" do
    @bob.password = @bob.password_confirmation = "password"
    @bob.save!
    
    get :update, :id => @bob.id, :user => {:name => 'george', :password => '', :password_confirmation => ''}
    
    @bob.reload.name.should == 'george'
    @bob.should be_valid_password("password")
  end
  
  it "should update all user attributes" do
    get :update, :id => @bob.id, :user => {:name => 'george', :password => 'jungle', :password_confirmation => 'jungle', :admin => true, :can_score => true}
    
    @bob.reload.name.should == 'george'
    @bob.should be_valid_password("jungle")
    @bob.can_score?.should == true
    @bob.admin?.should == true
  end
  
  it "should destroy a user" do
    delete :destroy, :id => @bob.id
    
    response.should redirect_to(admin_users_path)
    User.exists?(@bob.id).should be_false
  end
end
