require 'rails_helper'

RSpec.describe Downloader, type: :model do
  describe 'save_torrent' do
    it 'downloads a file' do
      expect(Downloader.save_torrent('test.torrent', 'http://xanderstrike.com/humans.txt')).to be_truthy
      expect(File.exist?('torrents/test.torrent')).to be_truthy
      File.delete('torrents/test.torrent') # don't forget to clean up
      expect(File.exist?('torrents/test.torrent')).to be_falsey
    end

    # it 'handles invalid uri errors' do
    #   url = ' invalid url '
    #   expect(Downloader.save_torrent('test.torrent', url)).to be_falsey
    # end
  end
end
