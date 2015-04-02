require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe '.parse_season_code' do
    it 'identifies the season and episode number from the name' do
      ep = Episode.new(name: '')
      expect(ep.ep_in_season).to be_nil
      expect(ep.season).to be_nil
      ep.name = 'Battlestar.Galactica.S02E11.HDTV.LAZYLEGUMELOL'
      ep.parse_season_code
      expect(ep.season).to eq(2)
      expect(ep.ep_in_season).to eq(11)
    end
  end

  describe 'hooks' do
    it 'runs parse_season_code on validation' do
      ep = Episode.new(name: 'Firefly S02E01', link: 'http://fakelink.com')
      expect(ep.season).to be_nil
      expect(ep.ep_in_season).to be_nil
      expect(ep.valid?).to be_truthy
      expect(ep.season).to eq(2) # :'(
      expect(ep.ep_in_season).to eq(1)
    end
  end
end
