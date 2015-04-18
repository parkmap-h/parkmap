class HomeController < ApplicationController
  def index
  end

  def search
    @parks = Park.search(params).includes(:photos)
    @start_at = params[:start_at].try(:in_time_zone) || Time.zone.now
    @end_at = params[:end_at].try(:in_time_zone) || @start_at.since(1.hour)
  end
end
