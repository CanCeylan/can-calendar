require 'spec_helper'

describe "resources/index" do
  before(:each) do
    assign(:resources, [
      stub_model(Resource),
      stub_model(Resource)
    ])
  end

  it "renders a list of resources" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
