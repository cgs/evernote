require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::Client" do
  it "initializes a ThriftClient instance that uses HTTP transport" do
    klass = mock("SomeInternalEvernoteClass")
    opts = { :transport => Thrift::HTTPClientTransport }
    ThriftClient.should_receive(:new).with(klass, "https://www.example.com", opts)
    
    Evernote::Client.new(klass, "https://www.example.com")
  end
end
