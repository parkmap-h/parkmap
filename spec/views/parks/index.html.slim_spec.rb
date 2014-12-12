require 'rails_helper'

RSpec.describe "parks/index", :type => :view do
  before(:each) do
    assign(:parks, [
      Park.create!(
        :name => "Name",
        :longitude => 1.5,
        :latitude => 1.5
      ),
      Park.create!(
        :name => "Name",
        :longitude => 1.5,
        :latitude => 1.5
      )
    ])
  end

  it "renders a list of parks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
