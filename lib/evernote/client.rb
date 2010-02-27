module Evernote
  class Client
  
    THRIFT_DEFAULTS = {
      :transport => Thrift::HTTPClientTransport
    }.freeze
  
    def initialize(klass, url, thrift_client_options = {})
      thrift_opts = THRIFT_DEFAULTS.merge(thrift_client_options)
      @client = ThriftClient.new(klass, url, thrift_opts)
    end
    
    def method_missing(name, *args, &block)
      @client.send(name, *args, &block)
    end
  end
end