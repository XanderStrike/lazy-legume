require 'rss'

class ScanRSS
  def initialize feed_url
    @xml = ScanRSS.get_xml(feed_url)
  end

  def find_for_rule rule
    find_episodes(/#{rule.regex}/i)
  end

  def find_episodes regex
    filter_valid_episodes(build_episodes(parse(regex)))
  end

  def parse regex
    feed = RSS::Parser.parse(@xml)
    [].tap do |results|
      feed.items.each do |item|
        unless item.title.scan(regex).empty?
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

  def self.get_xml feed
    open(feed)
  end
end
