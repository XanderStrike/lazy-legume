require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'hooks' do
    it 'destroys all episodes when destroyed' do
      show = create(:show)
      create_list(:episode, 5, show: show)
      expect { show.destroy }.to change { Episode.count }.by(-5)
    end

    it 'destroys all rules when destroyed' do
      show = create(:show)
      create_list(:rule, 5, show: show)
      expect { show.destroy }.to change { Rule.count }.by(-5)
    end
  end
end
