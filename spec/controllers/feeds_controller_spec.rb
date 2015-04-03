require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  describe 'get index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'gets all the feeds' do
      create_list(:feed, 5)
      get :index
      expect(assigns(:feeds).count).to eq(5)
    end
  end

  describe 'get show' do
    it 'gets the right feed' do
      feed = create(:feed)
      get :show, id: feed.id
      expect(assigns(:feed)).to eq(feed)
      expect(response).to render_template(:show)
    end
  end

  describe 'get new' do
    it 'instantiates a new feed' do
      get :new
      expect(assigns(:feed)).to be_a(Feed)
      expect(response).to render_template(:new)
    end
  end

  describe 'get edit' do
    it 'gets the right feed' do
      feed = create(:feed)
      get :edit, id: feed.id
      expect(assigns(:feed)).to eq(feed)
      expect(response).to render_template(:edit)
    end
  end

  describe 'get create' do
    it 'creates a new feed with the given params' do
      params = {
        feed: {
          name: 'test feed',
          url: 'http://dfasdfasdf.com'
        }
      }

      expect { get :create, params }.to change { Feed.count }.by(1)
      expect(assigns(:feed)).to be_a(Feed)
      expect(assigns(:feed).name).to eq('test feed')
      expect(assigns(:feed).url).to eq('http://dfasdfasdf.com')
      expect(response).to redirect_to(:feeds)
    end
  end

  describe 'get update' do
    it 'updates the feed' do
      feed = create(:feed, name: 'old name')
      params = {
        id: feed.id,
        feed: {
          name: 'new name'
        }
      }

      get :update, params
      expect(assigns(:feed)).to eq(feed)
      expect(assigns(:feed).name).to eq('new name')
      expect(response).to redirect_to(:feeds)
    end
  end

  describe 'delete destroy' do
    it 'deletes the feed' do
      feed = create(:feed)
      expect { delete :destroy, id: feed.id }.to change { Feed.count }.by(-1)
    end
  end
end
