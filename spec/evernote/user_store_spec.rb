require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::UserStore" do
  before(:each) do
    @opts = { :consumer_key => "12345", :consumer_secret => "ABCDE", :username => "cgs", :password => "password" }
    @thrift_client_opts = {}
  end

  it "initializes an Evernote::Client and validate the client code version" do
    client = mock("Evernote::Client", :client => mock("ThriftClient", :checkVersion => true))
    Evernote::Client.should_receive(:new).with(Evernote::EDAM::UserStore::UserStore::Client, "https://sandbox.evernote.com/edam/user", {}).and_return(client)

    Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
  end

  it "should raise an error on init if the version is not up to date" do
    client = mock("Evernote::Client", :client => mock("ThriftClient", :checkVersion => false))
    Evernote::Client.should_receive(:new).with(Evernote::EDAM::UserStore::UserStore::Client, "https://sandbox.evernote.com/edam/user", {}).and_return(client)

    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
    }.should raise_error(Evernote::VersionOutOfDate, "The vendored Evernote client code is out of date and needs to be regenerated")
  end
  
  it "raises an exception if no consumer key is set" do
    @opts.delete(:consumer_key)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

  it "raises an exception if no consumer secret is set" do
    @opts.delete(:consumer_secret)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

  it "raises an exception if no username is set" do
    @opts.delete(:username)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

  it "raises an exception if no password is set" do
    @opts.delete(:password)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, @thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

end
