class Park < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geog, RGeo::Geographic.spherical_factory(srid: 4326))

  attr_writer :longitude, :latitude

  before_create do
    self.geog = self.class.point(@longitude,@latitude)
  end

  scope :within_range ,-> point, distance {
    Park.where{st_distance(geog, point) < distance}
  }

  def self.point(longitude, latitude)
    Park.rgeo_factory_for_column(:geog).point(longitude,latitude)
  end

  def longitude
    geog.longitude
  end

  def latitude
    geog.latitude
  end

  # factory
  def self.create_nobori_10
    Park.create(
      name: '広島幟町第10',
      longitude: 132.467802,
      latitude: 34.393833,
    )
  end
end
