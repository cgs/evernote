require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::UserStore" do
  xit "initializes an Evernote::Client" do
    Evernote::Client.should_receive(:new).with(Evernote::EDAM::UserStore::UserStore::Client, "https://sandbox.evernote.com/edam/user")
    
    Evernote::UserStore.new("https://sandbox.evernote.com/edam/user")
  end
  
  xit "raises an exception if no consumer key is set" do
    Evernote::UserStore.new("https://sandbox.evernote.com/edam/user", {})
  end
  
  # opts = {
  #   :consumer_key => "mykey",
  #   :consumer_secret => "abcdefg123456",
  #   :username => "username",
  #   :password => "password"
  # }
end
