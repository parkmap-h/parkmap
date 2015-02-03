# park と
class ParkPhoto < ActiveRecord::Base
  belongs_to :park
  belongs_to :post_photo
end
