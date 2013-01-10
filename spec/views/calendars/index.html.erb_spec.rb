require 'spec_helper'

describe "calendars/index" do
  before(:each) do
    assign(:calendars, [
      stub_model(Calendar),
      stub_model(Calendar)
    ])
  end

  it "renders a list of calendars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
