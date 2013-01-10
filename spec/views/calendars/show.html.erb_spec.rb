require 'spec_helper'

describe "calendars/show" do
  before(:each) do
    @calendar = assign(:calendar, stub_model(Calendar))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
