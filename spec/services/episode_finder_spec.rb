require 'rails_helper'

RSpec.describe EpisodeFinder, type: :model do
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
  end
  let(:feed_xml) { IO.read(Rails.root.join('spec', 'fixtures', 'sample.xml')) }
  let(:scan_service) { ScanRSS.new('test_url') }

  describe '#find_new_for_feed' do
    it 'finds new episodes for each rule associated with a feed' do
      expect(ScanRSS).to receive(:get_xml).twice.and_return(feed_xml)

      feed = create(:feed)
      rule = create(:rule, regex: 'computer', feed: feed)
      rule1 = create(:rule, regex: 'restaurant', feed: feed)
      rule2 = create(:rule, regex: 'school', feed: feed)

      expect(rule.show.episodes.count).to eq(0)
      expect(rule1.show.episodes.count).to eq(0)
      expect(rule2.show.episodes.count).to eq(0)

      EpisodeFinder.find_new_for_feed(feed)

      expect(rule.show.episodes.count).to eq(1)
      expect(rule1.show.episodes.count).to eq(1)
      expect(rule2.show.episodes.count).to eq(1)

      EpisodeFinder.find_new_for_feed(feed)

      expect(rule.show.episodes.count).to eq(1)
      expect(rule1.show.episodes.count).to eq(1)
      expect(rule2.show.episodes.count).to eq(1)
    end

    it 'returns a list of episodes' do
      feed = create(:feed)
      create(:rule, regex: 'computer', feed: feed)
      eps = EpisodeFinder.find_new_for_feed(feed)

      expect(eps.first).to be_an(Episode)
    end
  end

  describe '#find_new_for_rule' do
    it 'only finds new and valid episodes for a given rule' do
      rule = create(:rule, regex: 'solutions')
      show = rule.show

      results = EpisodeFinder.find_new_for_rule(scan_service, rule)
      expect(results.count).to eq(7)

      show.episodes << create(:episode, name: 'Show S01E15')

      results = EpisodeFinder.find_new_for_rule(scan_service, rule)
      expect(results.count).to eq(6)

      show.episodes << create(:episode, name: 'S11E11')
      show.episodes << create(:episode, name: 'S05E19')
      show.episodes << create(:episode, name: 'S03E29')

      results = EpisodeFinder.find_new_for_rule(scan_service, rule)
      expect(results.count).to eq(4)
    end
  end
end
