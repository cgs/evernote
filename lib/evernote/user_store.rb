module Evernote

  VersionOutOfDate = Class.new(StandardError)

  class UserStore
    attr_reader :client

    def initialize(uri, opts = {}, thrift_client_options = {})
      @consumer_key = opts[:consumer_key]
      @consumer_secret = opts[:consumer_secret]
      @username = opts[:username]
      @password = opts[:password]

      unless @consumer_key && @consumer_secret && @username && @password
        raise ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required"
      end

      @client = Evernote::Client.new(Evernote::EDAM::UserStore::UserStore::Client, uri, thrift_client_options)

      validate_version
    end

    def validate_version
      raise VersionOutOfDate, "The vendored Evernote client code is out of date and needs to be regenerated" unless version_valid?
    end

    def version_valid?
      checkVersion("Ruby EDAMTest", Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR, Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
    end

    def method_missing(name, *args, &block)
      @client.client.send(name, *args, &block)
    end
  end
end
