require 'rails_helper'

RSpec.describe EpisodeFinder, :type => :model do
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
  end
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }
  let(:scan_service) { ScanRSS.new('test_url') }

  describe '#find_new_for_rule' do
    it 'only finds new and valid episodes for a given rule' do
      rule = create(:rule_with_feed_and_show, regex: "solutions")
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
