require 'rails_helper'

RSpec.describe Update, :type => :model do
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
    allow(Downloader).to receive(:save_torrent)
  end
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }

  describe '#fetch_all' do
    it 'fetches and downloads all the new episodes for all the feeds' do
      create_list(:rule_with_feed_and_show, 10)
      create_list(:episode, 5)
      create(:rule_with_feed_and_show, regex: 'computer')
      create(:rule_with_feed_and_show, regex: 'restaurant')
      expect(ScanRSS).to receive(:get_xml).exactly(12).times.and_return(feed_xml)
      expect(Downloader).to receive(:save_torrent).exactly(2).times
      expect { Update.fetch_all }.to change { Episode.count }.by(2)
    end
  end
end
