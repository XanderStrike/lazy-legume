require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe '#method_missing' do
    it 'gets the setting whos key is the method called' do
      expect(Setting.test_setting).to eq(nil)

      Setting.create(key: 'test_setting', str: '/home/wat/watch')

      s = Setting.test_setting

      expect(s).to be_a(Setting)
      expect(s.key).to eq('test_setting')
      expect(s.str).to eq('/home/wat/watch')
    end
  end
end
