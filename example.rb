require 'rubygems'
require 'evernote'

user_store_url = "https://sandbox.evernote.com/edam/user"

config = {
  :username => 'username',
  :password => 'password',
  :consumer_key => 'consumer_key',
  :consumer_secret => 'consumer_secret'
}

user_store = Evernote::UserStore.new(user_store_url, config)

auth_result = user_store.authenticate
user = auth_result.user
auth_token = auth_result.authenticationToken
puts "Authentication was successful for #{user.username}"
puts "Authentication token = #{auth_token}"

note_store_url = "http://sandbox.evernote.com/edam/note/#{user.shardId}"
note_store = Evernote::NoteStore.new(note_store_url)

notebooks = note_store.listNotebooks(auth_token)
puts "Found #{notebooks.size} notebooks:"
default_notebook = notebooks[0]
notebooks.each { |notebook| puts "  * #{notebook.name}"}
