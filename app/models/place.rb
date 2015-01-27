# 特定の場所を生成するファクトリ
class Place
  def self.point(longitude,latitude)
    Park.point(longitude, latitude)
  end

  def self.billing_510
    point(132.468539,34.393454)
  end

  def self.shakehands
    point(132.458730,34.393917)
  end

  def self.movinon
    point(132.465511,34.393056)
  end
end
