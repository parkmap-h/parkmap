json.type 'FeatureCollection'
json.features @parks do |park|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [park.longitude,park.latitude]
  end
  json.properies do
    json.name park.name
    json.distance number_to_human(park.distance) + " m"
  end
end
