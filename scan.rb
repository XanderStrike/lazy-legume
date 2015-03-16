require 'rss'
require 'open-uri'

DOWNLOAD_LOCATION = 'torrents'

class Rule
  attr :title, :quality

  def initialize title, quality
    @title = title
    @quality = quality
  end

  def to_regex
    "(#{@title}.*#{@quality})"
  end

  def self.to_regex rules_list
    /#{rules_list.map(&:to_regex).join('|')}/i
  end
end

class Episode
  attr :name, :season, :ep_in_season, :link

  def initialize name, link
    @name = name
    @link = link
    parse_season_code
  end

  def parse_season_code
    code = @name.scan(/S\d{2}E\d{2}/i).first.scan(/\d{2}/)
    @season = code.first.to_i
    @ep_in_season = code.last.to_i
  end

  def to_s
    "Season #{@season} Episode #{@ep_in_season} - #{@name}"
  end

  def download
    `wget #{@link} -O #{DOWNLOAD_LOCATION}/#{name.gsub(' ', '.')}.torrent`
  end
end

def parse f, r
  episodes = []

  open(f) do |rss|
    feed = RSS::Parser.parse(rss)
    puts "Title: #{feed.channel.title}"

    feed.items.each do |item|
      unless item.title.scan(r).empty?
        episodes << Episode.new(item.title, item.link)
      end
    end
  end

  episodes
end

rules = [
  Rule.new('Bobs Burgers', 'HDTV'),
  Rule.new('World Poker Tour', 'x264'),
]

episodes = parse(ARGV.first, Rule.to_regex(rules))
episodes.each do |ep|
  ep.download
end

puts episodes
