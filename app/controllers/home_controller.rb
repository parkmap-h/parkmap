class HomeController < ApplicationController
  def index
  end

  def search
    @parks = Park.search(params).includes(:photos)
  end
end
