require 'rubygems'
require 'thrift_client'

gen_rb_path = File.expand_path(File.dirname(__FILE__) + "/../vendor/gen-rb")
$LOAD_PATH.unshift gen_rb_path
$LOAD_PATH.unshift "#{gen_rb_path}/evernote/edam"
require "#{gen_rb_path}/evernote"
require "evernote/client"