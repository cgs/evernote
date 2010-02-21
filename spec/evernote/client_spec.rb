require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::Client" do
  it "initializes a ThriftClient instance that uses HTTP transport" do
    klass = mock("SomeInternalEvernoteClass")
    opts = { :transport => Thrift::HTTPClientTransport }
    ThriftClient.should_receive(:new).with(klass, "https://www.example.com", opts)
    
    Evernote::Client.new(klass, "https://www.example.com")
  end

  it "delegates method calls to the underlying ThriftClient" do
    client = Evernote::Client.new(Evernote::EDAM::UserStore::UserStore::Client, "https://www.example.com")
    internal_client = client.instance_variable_get(:@client)
    internal_client.stub(:checkVersion)
    internal_client.should_receive(:checkVersion)

    client.checkVersion
  end
end
