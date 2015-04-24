class Downloader
  class << self
    def save_torrent filename, url
      # TODO make a setting for torrent save location
      File.open("torrents/#{filename}",'w'){ |f|
        uri = URI.parse(url)
        Net::HTTP.start(uri.host,uri.port){ |http|
          http.request_get(uri.path){ |res|
            res.read_body{ |seg|
              f << seg
              sleep 0.005
            }
          }
        }
      }
    end
  end
end
