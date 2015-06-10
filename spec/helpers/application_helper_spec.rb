require 'rails_helper'

describe ApplicationHelper do
  describe "#bootstrap_alert" do
    it "creates some pretty html" do
      html = helper.bootstrap_alert(:warning, 'Oh no!')
      expect(html).to include('alert-warning')
      expect(html).to include('Oh no!')
    end
  end
end
