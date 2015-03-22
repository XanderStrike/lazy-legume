json.array!(@feeds) do |feed|
  json.extract! feed, :id, :name, :url
  json.url feed_url(feed, format: :json)
end
