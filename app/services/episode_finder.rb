class EpisodeFinder
  class << self
    def find_new_for_feed feed
      scan_service = ScanRSS.new(feed.url)

      feed.rules.each do |r|
        r.show.episodes << find_new_for_rule(scan_service, r)
      end
    end

    def find_new_for_rule scan_service, rule
      episodes = scan_service.find_for_rule(rule)
      existing_episodes = rule.show.episodes
      episodes.select do |ep|
        existing_episodes.where(season: ep.season, ep_in_season: ep.ep_in_season).empty?
      end
    end
  end
end
