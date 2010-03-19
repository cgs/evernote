module Evernote
  class NoteStore
    def initialize(uri, thrift_client_options = {})
      @client = Evernote::Client.new(Evernote::EDAM::NoteStore::NoteStore::Client, uri, thrift_client_options)
    end
    
    def method_missing(name, *args, &block)
      @client.send(name, *args, &block)
    end
  end
end
