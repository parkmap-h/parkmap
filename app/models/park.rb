class Park < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geog, RGeo::Geographic.spherical_factory(srid: 4326))

  has_many :park_photos
  has_many :photos, through: :park_photos, source: :post_photo

  validates :name, presence: true

  attr_writer :longitude, :latitude

  before_create do
    self.geog = self.class.point(@longitude,@latitude)
  end

  scope :within_range ,-> point, distance {
    Park.where{st_distance(geog, point) < distance}
      .select{[st_distance(geog, point),'*']}
  }

  def self.point(longitude, latitude)
    Park.rgeo_factory_for_column(:geog,{}).point(longitude,latitude)
  end

  def self.search(params)
    point = point(params[:longitude].to_f,params[:latitude].to_f)
    within_range(point,params[:distance])
  end

  def longitude
    geog.try(:longitude)
  end

  def latitude
    geog.try(:latitude)
  end

  def distance
    st_distance
  end

  # 今から1時間停めたときの料金
  def hour_fee
    case fee['type']
    when 'text'
      nil
    else
      FeeCalculator.new(fee).hour_fee
    end
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
