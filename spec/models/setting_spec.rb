require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe '#method_missing' do
    it 'gets the setting whos key is the method called' do
      expect(Setting.torrent_location).to eq(nil)

      Setting.create(key: 'torrent_location', str: '/home/wat/watch')

      s = Setting.torrent_location

      expect(s).to be_a(Setting)
      expect(s.key).to eq('torrent_location')
      expect(s.str).to eq('/home/wat/watch')
    end
  end
end
