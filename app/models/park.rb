class Park < ActiveRecord::Base
  has_many :park_photos
  has_many :photos, through: :park_photos, source: :post_photo

  validates :name, presence: true
  validate :fee_check

  attr_writer :longitude, :latitude

  before_save do
    if @longitude && @latitude
      self.geog = self.class.point(@longitude, @latitude)
    end
  end

  scope :within_range ,-> point, distance {
    Park.where{st_distance(geog, point) < distance}
      .select{[st_distance(geog, point),'*']}
  }

  def self.point(longitude, latitude)
    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    factory.point(longitude,latitude)
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

  def calc_fee(start, ended)
    case fee['type']
    when 'text'
      nil
    else
      FeeCalculator.new(fee).calc(start...ended)
    end
  end

  # 今から1時間停めたときの料金
  def hour_fee(time=Time.zone.now)
    case fee['type']
    when 'text'
      nil
    else
      FeeCalculator.new(fee).hour_fee(time)
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

  def fee_check
    return unless fee_changed?

    24.times do |n|
      hour_fee(Time.zone.now + n.hour)
    end
  end
end
