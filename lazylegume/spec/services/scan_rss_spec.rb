require 'rails_helper'

RSpec.describe ScanRSS, :type => :model do
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }

  describe '#parse' do
    it 'returns RSS objects for each matching item' do
      expect(ScanRSS).to receive(:get_xml).and_return(feed_xml)
      expect(ScanRSS.parse('http://www.feedforall.com/sample.xml', /computer/i).map(&:title))
        .to eq(['RSS Solutions for Computer Service Companies'])
    end
  end
end
