require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::UserStore" do
  before(:each) do
    @opts = { :consumer_key => "12345", :consumer_secret => "ABCDE", :username => "cgs", :password => "password" }
  end

  it "initializes an Evernote::Client" do
    Evernote::Client.should_receive(:new).with(Evernote::EDAM::UserStore::UserStore::Client, "https://sandbox.evernote.com/edam/user", {})

    Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts)
  end

  it "raises an exception if no consumer key is set" do
    thrift_client_opts = {}
    @opts.delete(:consumer_key)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end
              
  it "raises an exception if no consumer secret is set" do
    thrift_client_opts = {}
    @opts.delete(:consumer_secret)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

  it "raises an exception if no username is set" do
    thrift_client_opts = {}
    @opts.delete(:username)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end

  it "raises an exception if no password is set" do
    thrift_client_opts = {}
    @opts.delete(:password)
    lambda {
      Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", @opts, thrift_client_opts)
    }.should raise_error(ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required")
  end
end
