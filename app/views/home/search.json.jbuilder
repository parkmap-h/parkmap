json.array!(@parks) do |park|
  json.extract! park, :id, :name, :longitude, :latitude
  json.distance number_to_human(park.distance) + " m"
end
