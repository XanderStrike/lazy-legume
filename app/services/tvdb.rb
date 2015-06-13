class Tvdb
  def initialize key=nil
    @client = TTVDB::Client.new
  end

  def search q
    @client.get_series(q)[0..5].map do |s|
      @client.get_series_by_id(s.id)
    end
  end
end
