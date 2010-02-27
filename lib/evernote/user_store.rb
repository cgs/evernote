module Evernote

  VersionOutOfDate = Class.new(StandardError)

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
      
      validate_version
    end
    
    def authenticate
      @client.authenticate(@username, @password, @consumer_key, @consumer_secret)
    rescue Evernote::EDAM::Error::EDAMUserException
      raise AuthenticationFailure
    end
    
    def method_missing(name, *args, &block)
      @client.send(name, *args, &block)
    end

    def validate_version
      raise VersionOutOfDate, "The vendored Evernote client code is out of date and needs to be regenerated" unless version_valid?
    end

    def version_valid?
      checkVersion("Ruby EDAMTest", Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR, Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
    end
  end
end
