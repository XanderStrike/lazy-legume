require 'rss'

class ScanRSS
  class << self
    def find_episodes f, r
      filter_valid_episodes(build_episodes(parse(f, r)))
    end

    def parse f, r
      feed = RSS::Parser.parse(get_xml(f))
      [].tap do |results|
        feed.items.each do |item|
          unless item.title.scan(r).empty?
            results << item
          end
        end
      end
    end

    def build_episodes items
      items.map do |item|
        Episode.new(name: item.title, link: item.link)
      end
    end

    def filter_valid_episodes eps
      eps.select do |ep|
        ep.valid?
      end
    end

    private

    def get_xml feed
      @xml || @xml = open(feed)
    end
  end
end
