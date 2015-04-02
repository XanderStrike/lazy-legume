require 'rss'

class ScanRSS
  class << self
    def parse f, r
      feed = RSS::Parser.parse(get_xml(f))
      [].tap do |items|
        feed.items.each do |item|
          unless item.title.scan(r).empty?
            items << item
          end
        end
      end
    end

    private

    def get_xml feed
      open(feed)
    end
  end
end
