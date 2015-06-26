require 'rails_helper'

RSpec.describe Rule, type: :model do
  describe '#build_for_show' do
    it 'builts regex for a show given params and a show id' do
      show = create(:show, name: "Marvel's Agents of S.H.I.E.L.D (2013)")
      feed = create(:feed)

      rule = nil
      expect { rule = Rule.build_for_show(show, quality: '(1080|720)') }.to change(Rule, :count).by(1)
      expect(rule.show).to eq(show)
      expect(rule.feed).to eq(feed)
      expect(rule.keywords).to eq('marvel s agents of s h i e l d 2013')
      expect(rule.quality).to eq('(1080|720)')
      expect(rule.regex).to eq('marvel.*s.*agents.*of.*s.*h.*i.*e.*l.*d.*2013.*(1080|720)')
    end
  end
end
