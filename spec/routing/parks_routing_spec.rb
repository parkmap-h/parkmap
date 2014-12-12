require "rails_helper"

RSpec.describe ParksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/parks").to route_to("parks#index")
    end

    it "routes to #new" do
      expect(:get => "/parks/new").to route_to("parks#new")
    end

    it "routes to #show" do
      expect(:get => "/parks/1").to route_to("parks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/parks/1/edit").to route_to("parks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/parks").to route_to("parks#create")
    end

    it "routes to #update" do
      expect(:put => "/parks/1").to route_to("parks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/parks/1").to route_to("parks#destroy", :id => "1")
    end

  end
end
