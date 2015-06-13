require 'rails_helper'

RSpec.describe Tvdb, :type => :model do
  describe '.initialize' do
    it 'creates an instance of the tvdb client' do
      client = Tvdb.new()
      expect(client.instance_variable_get(:@client)).to be_a(TTVDB::Client)
    end
  end

  describe '.search' do
    it 'finds shows that match the title' do
      client = Tvdb.new()
      series = client.search "Galaxy Rangers"
      expect(series).to be_instance_of Array
      expect(series.count).to be >= 1
      expect(series[0].name).to eql("The Adventures of the Galaxy Rangers")
      expect(series[0].language).to eql("en")
      expect(series[0].poster).to be_a(String)
      expect(series[0].id).to eql(77772)
    end
  end
end
