module Evernote
  class UserStore
    def initialize(uri, opts = {}, thrift_client_options = {})
      @consumer_key = opts[:consumer_key]
      @consumer_secret = opts[:consumer_secret]
      @username = opts[:username]
      @password = opts[:password]

      unless @consumer_key && @consumer_secret && @username && @password
        raise ArgumentError, ":consumer_key, :consumer_secret, :username and :password are required"
      end

      Evernote::Client.new(Evernote::EDAM::UserStore::UserStore::Client, uri, thrift_client_options)
    end
  end
end
