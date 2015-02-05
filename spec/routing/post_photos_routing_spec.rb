require "rails_helper"

RSpec.describe PostPhotosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/posts").to route_to("post_photos#index")
    end

    it "routes to #new" do
      expect(:get => "/posts/new").to route_to("post_photos#new")
    end

    it "routes to #show" do
      expect(:get => "/posts/1").to route_to("post_photos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/posts/1/edit").to route_to("post_photos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/posts").to route_to("post_photos#create")
    end

    it "routes to #update" do
      expect(:put => "/posts/1").to route_to("post_photos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/posts/1").to route_to("post_photos#destroy", :id => "1")
    end

  end
end
