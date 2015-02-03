# 駐車場と投稿してもらった写真を結ぶためのテーブル
class ParkPhoto < ActiveRecord::Base
  belongs_to :park
  belongs_to :post_photo

  # まだ駐車場と結びついていないもの
  scope :no_relation, -> { where.not(id: ParkPhoto.select(:post_photo_id)) }
end
