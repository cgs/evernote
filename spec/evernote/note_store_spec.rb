require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Evernote::NoteStore" do
  it "should proxy methods" do
    note_store = Evernote::NoteStore.new("http://sandbox.evernote.com/edam/note/")
    note_store.instance_variable_get(:@client).should_receive(:foobar).and_return(nil)

    note_store.foobar
  end
end
