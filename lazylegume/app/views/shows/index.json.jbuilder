json.array!(@shows) do |show|
  json.extract! show, :id, :name
  json.url show_url(show, format: :json)
end
