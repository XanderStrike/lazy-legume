require 'rails_helper'

RSpec.describe Downloader, :type => :model do
  describe 'save_torrent' do
    it 'downloads a file' do
      Downloader.save_torrent 'test.torrent', 'http://xanderstrike.com/humans.txt'
      expect(File.exists?('torrents/test.torrent')).to be_truthy
      File.delete('torrents/test.torrent') # don't forget to clean up
      expect(File.exists?('torrents/test.torrent')).to be_falsey
    end
  end
end