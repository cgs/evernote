require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::UserStore" do
  before(:each) do
    @auth_file = File.dirname(__FILE__) + "/auth.yaml"
    @env = :sandbox
  end

  it "initializes an Evernote::Client and validate the client code version" do
    client = mock("Evernote::Client", :checkVersion => true)
    Evernote::Client.should_receive(:new).with(Evernote::EDAM::UserStore::UserStore::Client, "https://sandbox.evernote.com/edam/user", {}).and_return(client)
  
    Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, @env)
  end
  
  it "should raise an error on init if the version is not up to date" do
    Evernote::Client.stub!(:new => mock("Evernote::Client", :checkVersion => false))
  
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, @env)
    }.should raise_error(Evernote::VersionOutOfDate, "The vendored Evernote client code is out of date and needs to be regenerated")
  end

  %w(consumer_key consumer_secret username password).each do |credential|
    it "raises an exception if no #{credential} is set" do            
      lambda {
        Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, :invalid)
      }.should raise_error(ArgumentError, "'consumer_key', 'consumer_secret', 'username' and 'password' are required")
    end
  end
  
  it "should authenticate" do
    Evernote::Client.stub!(:new => mock("Evernote::Client", :checkVersion => true))
    user_store = Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, @env)
    user_store.instance_variable_get(:@client).should_receive(:authenticate).with("cgs", "password", "12345", "ABCDE").and_return(nil)
    
    user_store.authenticate
  end
  
  it "should wrap authentication failure" do
    Evernote::Client.stub!(:new => mock("Evernote::Client", :checkVersion => true))
    user_store = Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, @env)
    user_store.instance_variable_get(:@client).should_receive(:authenticate).and_raise(Evernote::EDAM::Error::EDAMUserException)
    
    lambda {
      user_store.authenticate
    }.should raise_error(Evernote::UserStore::AuthenticationFailure)
  end
  
  it "should proxy methods" do
    Evernote::Client.stub!(:new => mock("Evernote::Client", :checkVersion => true))
    user_store = Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @auth_file, @env)
    user_store.instance_variable_get(:@client).should_receive(:foobar).and_return(nil)
    
    user_store.foobar
  end
end
