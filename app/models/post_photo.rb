require 'carrierwave/orm/activerecord'
class PostPhoto < ActiveRecord::Base
  mount_uploader :photo, PostphotoUploader
  validates :geog, presence: {message: "が付与されていません。写真に位置情報があったとしてもiOS端末からアップロードすると削除されます。PCからアップロードしてください。" }

  has_many :park_photos
  has_many :parks, through: :park_photos

  # まだ駐車場と結びついていないもの
  scope :no_relation, -> { where.not(id: ParkPhoto.select(:post_photo_id)) }

  before_validation do
    next if persisted?
    next if photo.file.nil?

    @exif ||= EXIFR::JPEG.new(photo.file.file)
    if gps = @exif.gps
      self.geog = Park.point(gps.longitude, gps.latitude)
    end
  end
end
