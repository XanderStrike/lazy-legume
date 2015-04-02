require 'rails_helper'

RSpec.describe ScanRSS, :type => :model do
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
  end
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }
  let(:items) { ScanRSS.parse('test_url', //) }


  describe '#find_episodes' do
    it 'calls the necessary methods' do
      ScanRSS.find_episodes('test_url', /computer/i)
    end
  end

  describe '#parse' do
    it 'returns RSS items for each matching the rss rule' do
      expect(ScanRSS).to receive(:get_xml).and_return(feed_xml)
      expect(ScanRSS.parse('test_url', /computer/i).map(&:title))
        .to eq(['RSS SolutioS25E33ns for Computer Service Companies'])
    end
  end

  describe '#build_episodes' do
    it 'returns a list of episodes' do
      episodes = ScanRSS.build_episodes(items)
      expect(episodes.first).to be_an(Episode)
      expect(episodes.first.name).to eq('RSS Solutions for S01E15 Restaurants')
      expect(episodes.first.valid?).to be_truthy
      expect(episodes.last.valid?).to be_falsey
    end
  end

  describe '#filter_valid_episodes' do
    it 'removes invalid episodes' do
      episodes = ScanRSS.build_episodes(items)
      expect(episodes.count).to eq(9)
      filtered_episodes = ScanRSS.filter_valid_episodes(episodes)
      expect(filtered_episodes.count).to eq(8)
    end
  end
end
