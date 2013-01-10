require 'spec_helper'

describe "resources/new" do
  before(:each) do
    assign(:resource, stub_model(Resource).as_new_record)
  end

  it "renders new resource form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => resources_path, :method => "post" do
    end
  end
end
