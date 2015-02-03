# 駐車場と投稿してもらった写真を結ぶためのテーブル
class ParkPhoto < ActiveRecord::Base
  belongs_to :park
  belongs_to :post_photo
end
