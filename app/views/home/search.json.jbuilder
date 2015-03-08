json.type 'FeatureCollection'
json.features @parks do |park|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [park.longitude,park.latitude]
  end
  json.properties do
    json.name park.name
    json.id park.id
    json.distance_human number_to_human(park.distance) + " m"
    json.distance park.distance
    json.photos park.photos.map {|photo| photo.photo.url}
    json.mini_photos park.photos.map {|photo| photo.photo.mini.url}
    json.thumb_photos park.photos.map {|photo| photo.photo.thumb.url}
    json.hour_fee park.hour_fee
  end
end
