require 'rails_helper'

RSpec.describe "parks/edit", :type => :view do
  before(:each) do
    @park = assign(:park, Park.create!(
      :name => "MyString",
      :longitude => 1.5,
      :latitude => 1.5
    ))
  end

  it "renders the edit park form" do
    render

    assert_select "form[action=?][method=?]", park_path(@park), "post" do

      assert_select "input#park_name[name=?]", "park[name]"

      assert_select "input#park_longitude[name=?]", "park[longitude]"

      assert_select "input#park_latitude[name=?]", "park[latitude]"
    end
  end
end
