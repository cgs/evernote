module Evernote
  class Client
  
    THRIFT_DEFAULTS = {
      :transport => Thrift::HTTPClientTransport
    }.freeze
  
    def initialize(klass, url, thrift_client_options = {})
      thrift_opts = THRIFT_DEFAULTS.merge(thrift_client_options)
      ThriftClient.new(klass, url, thrift_opts)
    end
  end
end