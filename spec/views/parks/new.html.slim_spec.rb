require 'rails_helper'

RSpec.describe "parks/new", :type => :view do
  before(:each) do
    assign(:park, Park.new(
      :name => "MyString",
      :longitude => 1.5,
      :latitude => 1.5
    ))
  end

  it "renders new park form" do
    render

    assert_select "form[action=?][method=?]", parks_path, "post" do

      assert_select "input#park_name[name=?]", "park[name]"

      assert_select "input#park_longitude[name=?]", "park[longitude]"

      assert_select "input#park_latitude[name=?]", "park[latitude]"
    end
  end
end
