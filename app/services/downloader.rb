class Downloader
  class << self
    def save_torrent(filename, url)
      # TODO: make a setting for torrent save location
      puts "Saving #{ filename }"

      `wget -O "torrents/#{ filename }" "#{ url }" 1> /dev/null 2> /dev/null`

      # TODO: download files the ruby way so we can handle errors
      #   File.open("torrents/#{filename}",'w') do |f|
      #     uri = URI.parse(url)
      #     http = Net::HTTP.new(uri.host, uri.port)
      #     http.use_ssl = true if url.start_with?('https')
      #     http.start do |http|
      #       http.request_get(uri.path) do |res|
      #         res.read_body do |seg|
      #           f << seg
      #           sleep 0.005
      #         end
      #       end
      #     end
      #   end
      #   return true
      # rescue URI::InvalidURIError
      #   puts "Could not download malformed url: #{url}"
      #   return false
    end
  end
end
