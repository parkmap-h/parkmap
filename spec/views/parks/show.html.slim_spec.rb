require 'rails_helper'

RSpec.describe "parks/show", :type => :view do
  before(:each) do
    @park = assign(:park, Park.create!(
      :name => "Name",
      :longitude => 1.5,
      :latitude => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1.5/)
  end
end
