require 'rails_helper'

RSpec.describe "Posts", :type => :request do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      get post_photos_path
      expect(response.status).to be(200)
    end
  end

  describe "GET /posts/recent" do
    it "works! (now write some real specs)" do
      get recent_post_photos_path
      expect(response.status).to be(200)
    end
  end
end
