require 'carrierwave/orm/activerecord'
class PostPhoto < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geog, RGeo::Geographic.spherical_factory(srid: 4326))
  mount_uploader :photo, PostphotoUploader
end
