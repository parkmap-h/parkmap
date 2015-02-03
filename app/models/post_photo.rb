require 'carrierwave/orm/activerecord'
class PostPhoto < ActiveRecord::Base
  self.rgeo_factory_generator = RGeo::Geos.factory_generator
  set_rgeo_factory_for_column(:geog, RGeo::Geographic.spherical_factory(srid: 4326))
  mount_uploader :photo, PostphotoUploader
  validates :geog, presence: {message: "が付与されていません。写真に位置情報があったとしてもiOS端末からアップロードすると削除されます。PCからアップロードしてください。" }

  has_many :park_photos
  has_many :parks, through: :park_photos

  before_validation do
    if photo.file.nil?
      next
    end
    @exif ||= EXIFR::JPEG.new(photo.file.file)
    if gps = @exif.gps
      self.geog = Park.point(gps.longitude, gps.latitude)
      self.image_direction = gps.image_direction
    end
  end
end
