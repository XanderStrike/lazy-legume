require 'rails_helper'

RSpec.describe ScanRSS, :type => :model do
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
  end
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }
  let(:items) { ScanRSS.new('test_url').parse(//) }
  let(:scan_service) { ScanRSS.new('test_url') }

  describe '.find_for_rule' do
    it 'calls the necessary methods' do
      rule = build(:rule_with_feed_and_show)
      expect(scan_service).to receive(:find_episodes).with(/#{rule.regex}/i)

      scan_service.find_for_rule(rule)
    end
  end

  describe '.find_episodes' do
    it 'calls the necessary methods' do
      expect(scan_service).to receive(:filter_valid_episodes)
      expect(scan_service).to receive(:build_episodes)
      expect(scan_service).to receive(:parse)
      scan_service.find_episodes(//)
    end
  end

  describe '.parse' do
    it 'returns RSS items for each matching the rss rule' do
      expect(scan_service.parse(/computer/i).map(&:title))
        .to eq(['RSS SolutioS25E33ns for Computer Service Companies'])
    end
  end

  describe '.build_episodes' do
    it 'returns a list of episodes' do
      episodes = scan_service.build_episodes(items)
      expect(episodes.first).to be_an(Episode)
      expect(episodes.first.name).to eq('RSS Solutions for S01E15 Restaurants')
      expect(episodes.first.valid?).to be_truthy
      expect(episodes.last.valid?).to be_falsey
    end
  end

  describe '.filter_valid_episodes' do
    it 'removes invalid episodes' do
      episodes = scan_service.build_episodes(items)
      expect(episodes.count).to eq(9)
      filtered_episodes = scan_service.filter_valid_episodes(episodes)
      expect(filtered_episodes.count).to eq(8)
    end
  end
end
