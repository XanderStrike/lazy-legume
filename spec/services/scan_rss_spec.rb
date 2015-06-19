require 'rails_helper'

RSpec.describe ScanRSS, :type => :model do
  before(:each) do |example|
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml) unless example.metadata[:skip_stub]
  end
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }
  let(:items) { ScanRSS.new('test_url').parse(//) }
  let(:scan_service) { ScanRSS.new('test_url') }
  let(:rule) { create(:rule) }

  describe '.initialize' do
    it 'gets the xml for the feed url' do
      expect(ScanRSS).to receive(:get_xml).with('test_feed_url').and_return(feed_xml)
      service = ScanRSS.new('test_feed_url')
      expect(service.instance_variable_get(:@feed).items.count).to eq(RSS::Parser.parse(feed_xml).items.count)
    end
  end

  describe '.find_for_rule' do
    it 'calls the necessary methods' do
      expect(scan_service).to receive(:find_episodes).with(/#{rule.regex}/i, rule)

      scan_service.find_for_rule(rule)
    end
  end

  describe '.find_episodes' do
    it 'calls the necessary methods' do
      expect(scan_service).to receive(:filter_valid_episodes)
      expect(scan_service).to receive(:build_episodes)
      expect(scan_service).to receive(:parse)
      scan_service.find_episodes(//, rule)
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
      episodes = scan_service.build_episodes(items, rule)
      expect(episodes.first).to be_an(Episode)
      expect(episodes.first.name).to eq('RSS Solutions for S01E15 Restaurants')
      expect(episodes.first.valid?).to be_truthy
      expect(episodes.last.valid?).to be_falsey
    end
  end

  describe '.filter_valid_episodes' do
    it 'removes invalid episodes' do
      episodes = scan_service.build_episodes(items, rule)
      expect(episodes.count).to eq(9)
      filtered_episodes = scan_service.filter_valid_episodes(episodes)
      expect(filtered_episodes.count).to eq(8)
    end
  end

  describe '#get_xml', :skip_stub do
    it 'gets xml from a server' do
      VCR.use_cassette('scan-rss-get-xml') do
        xml = ScanRSS.get_xml('http://www.feedforall.com/sample.xml')

        expect(xml.status).to eq(["200", "OK"])
        expect(xml.meta['content-type']).to eq('application/xml')
      end
    end
  end
end
