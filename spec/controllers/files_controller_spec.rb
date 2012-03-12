require 'spec_helper'

describe FilesController do
  it "should serve a file" do
    DROPBOX = mock(:dropbox)
    DROPBOX.should_receive(:get_file).with("/HSD/online/foo.png").and_return("stuff")

    get :show, :id => "foo", :format => "png"

  end
end
