class Update
  class << self
    def fetch_all
      puts "Started update at #{ Time.now.to_s }"
      new_eps = all_new_eps
      new_eps.map(&:download)
      puts "Done\n"
    end

    def all_new_eps
      [].tap do |episodes|
        Feed.all.each do |feed|
          episodes << EpisodeFinder.find_new_for_feed(feed)
        end
      end .flatten
    end
  end
end
