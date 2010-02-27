module Evernote
  class UserStore
    AuthenticationFailure = Class.new(StandardError)
    
    def initialize(uri, auth_file, auth_env, thrift_client_options = {})
      credentials = YAML.load_file(auth_file)[auth_env.to_s]
      
      @consumer_key = credentials["consumer_key"]
      @consumer_secret = credentials["consumer_secret"]
      @username = credentials["username"]
      @password = credentials["password"]

      unless @consumer_key && @consumer_secret && @username && @password
        raise ArgumentError, "'consumer_key', 'consumer_secret', 'username' and 'password' are required"
      end

      @client = Evernote::Client.new(Evernote::EDAM::UserStore::UserStore::Client, uri, thrift_client_options)
    end
    
    def authenticate
      @client.authenticate(@username, @password, @consumer_key, @consumer_secret)
    rescue Evernote::EDAM::Error::EDAMUserException
      raise AuthenticationFailure
    end
    
    def method_missing(name, *args, &block)
      @client.send(name, *args, &block)
    end
  end
end
