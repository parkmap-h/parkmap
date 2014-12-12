require 'rails_helper'

RSpec.describe "Parks", :type => :request do
  describe "GET /parks" do
    it "works! (now write some real specs)" do
      get parks_path
      expect(response.status).to be(200)
    end
  end
end
