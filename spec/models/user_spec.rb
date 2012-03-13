require 'spec_helper'

describe User do
  let(:auth_hash) do
    {provider:"google", uid:"123", info:{ email:"jeremy@example.com", name:"Jeremy" }}
  end

#provider: google
#uid: https://www.google.com/accounts/o8/id?id=AItOawkdkFUf7UHmKjh9s30DpOscFq-ZRL07Rvo
#info: !map:OmniAuth::AuthHash::InfoHash 
  #email: jeremy.lightsmith@gmail.com
  #first_name: Jeremy
  #last_name: Lightsmith
  #name: Jeremy Lightsmith
  it "should create user from auth hash" do
    u = User.find_or_create_from_auth_hash(auth_hash) 
   
    u.reload
    u.provider.should == "google"
    u.uid.should == "123"
    u.email.should == "jeremy@example.com"
    u.name.should == "Jeremy"
  end

  it "should find user from auth hash and update params" do
    u1 = User.find_or_create_from_auth_hash(auth_hash)
    u2 = User.find_or_create_from_auth_hash(provider:"google", uid:"123", info:{email:"j@foo", name:"Joe"})

    u1.should == u2
    u2.email.should == "j@foo"
    u2.name.should == "Joe"
  end
end
