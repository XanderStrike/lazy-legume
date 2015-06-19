class Tvdb
  def initialize key=nil
    @client = TTVDB::Client.new
  end

  def search q
    @client.get_series(q)[0..5].map do |s|
      lookup(s.id)
    end
  end

  def lookup id
    @client.get_series_by_id(id)
  end
end
