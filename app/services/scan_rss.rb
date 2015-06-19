require 'rss'

class ScanRSS
  def initialize feed_url
    @feed = RSS::Parser.parse(ScanRSS.get_xml(feed_url))
  end

  def find_for_rule rule
    find_episodes(/#{rule.regex}/i, rule)
  end

  def find_episodes regex, rule
    filter_valid_episodes(build_episodes(parse(regex), rule))
  end

  def parse regex
    [].tap do |results|
      @feed.items.each do |item|
        unless item.title.scan(regex).empty?
          results << item
        end
      end
    end
  end

  def build_episodes items, rule
    items.map do |item|
      Episode.new(name: item.title, link: item.link, show: rule.show)
    end
  end

  def filter_valid_episodes eps
    eps.select do |ep|
      ep.valid?
    end
  end

  def self.get_xml feed
    open(feed, allow_redirections: :all)
  end
end
