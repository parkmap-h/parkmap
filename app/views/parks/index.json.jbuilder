json.array!(@parks) do |park|
  json.extract! park, :id, :name, :longitude, :latitude, :distance
  json.url park_url(park, format: :json)
end
