require 'rails_helper'

RSpec.describe RulesController, type: :controller do
  let(:show) { create(:show) }
  let(:feed) { create(:feed) }
  let(:feed_xml) { IO.read(Rails.root.join("spec", "fixtures", "sample.xml")) }
  before(:each) do
    allow(ScanRSS).to receive(:get_xml).and_return(feed_xml)
  end

  describe 'get new' do
    it 'instantiates a new rule and renders the new template' do
      get :new, show: show.id, format: :js
      expect(assigns(:show)).to eq(show)
      expect(assigns(:rule)).to be_a(Rule)
      expect(response).to render_template(:new)
    end
  end

  describe 'get create' do
    context 'as save' do
      it 'creates a rule with the given params' do
        params = { rule: {
            show_id: show.id,
            regex: 'test regex',
            feed_id: feed.id },
          commit: 'Save',
          format: :js }

        expect { get :create, params }.to change { Rule.count }.by(1)

        expect(assigns(:show)).to eq(show)
        expect(assigns(:rule)).to be_a(Rule)
        expect(assigns(:rule).show_id).to eq(show.id)
        expect(assigns(:rule).feed_id).to eq(feed.id)
        expect(assigns(:rule).regex).to eq('test regex')
      end
    end

    context 'as test' do
      it 'gets the episodes that match the rule and renders the test template' do
        params = { rule: {
            show_id: show.id,
            regex: '(computer|restaurant)',
            feed_id: feed.id },
          commit: 'Test',
          format: :js }

        get :create, params

        expect(assigns(:found_eps).first).to be_an(Episode)
        expect(assigns(:found_eps).count).to eq(2)
      end
    end
  end

  describe 'get update' do
    context 'as save' do
      it 'updates a rule with the given params' do
        rule = create(:rule_with_feed_and_show, regex: 'old regex')
        expect(rule.regex).to eq('old regex')
        params = {
          id: rule.id,
          rule: {
            show_id: rule.show.id,
            regex: 'new regex',
            feed_id: rule.feed.id },
          commit: 'Save',
          format: :js }

        expect { get :update, params }.to change { Rule.count }.by(0)

        expect(assigns(:show)).to eq(rule.show)
        expect(assigns(:rule)).to be_a(Rule)
        expect(assigns(:rule).regex).to eq('new regex')
      end
    end

    context 'as test' do
      it 'gets the episodes that match the rule and renders the test template' do
        rule = create(:rule_with_feed_and_show)
        params = {
          id: rule.id,
          rule: {
            show_id: show.id,
            regex: '(computer|restaurant)',
            feed_id: feed.id },
          commit: 'Test',
          format: :js }

        get :update, params

        expect(assigns(:found_eps).first).to be_an(Episode)
        expect(assigns(:found_eps).count).to eq(2)
      end
    end
  end

  describe 'delete destroy' do
    it 'destroys the rule' do
      rule = create(:rule)
      expect { delete :destroy, id: rule.id, format: :js }.to change { Rule.count }.by(-1)
    end
  end
end
