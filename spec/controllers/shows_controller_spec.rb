require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  describe 'get index' do
    it 'gets all the shows and renders the index template' do
      create_list(:show, 5)
      get :index
      expect(assigns(:shows).first).to be_a(Show)
      expect(assigns(:shows).count).to eq(5)
      expect(response).to render_template(:index)
    end
  end

  describe 'get show' do
    it 'gets the right show' do
      show = create(:show)
      get :show, id: show.id

      expect(assigns(:show)).to eq(show)
    end

    it 'gets a sorted list of episodes for the show' do
      show = create(:show_with_episodes)
      get :show, id: show.id

      expect(assigns(:episodes)).to eq(show.episodes.order(:season, :ep_in_season))
    end
  end

  describe 'get new' do
    it 'instantiates a new show' do
      get :new
      expect(assigns(:show)).to be_a(Show)
      expect(response).to render_template(:new)
    end
  end

  describe 'get edit' do
    it 'gets the right show' do
      show = create(:show)
      get :edit, id: show.id
      expect(assigns(:show)).to eq(show)
      expect(response).to render_template(:edit)
    end
  end

  describe 'put create' do
    it 'creates a new show with the given params' do
      params = {
        show: {
          name: 'test show',
          url: 'http://dfasdfasdf.com'
        }
      }

      expect { put :create, params }.to change { Show.count }.by(1)
      expect(assigns(:show)).to be_a(Show)
      expect(assigns(:show).name).to eq('test show')
      expect(response).to redirect_to(assigns(:show))
    end
  end

  describe 'put update' do
    it 'updates the show' do
      show = create(:show, name: 'old name')
      params = {
        id: show.id,
        show: {
          name: 'new name'
        }
      }

      put :update, params
      expect(assigns(:show)).to eq(show)
      expect(assigns(:show).name).to eq('new name')
      expect(response).to redirect_to(assigns(:show))
    end
  end

  describe 'delete destroy' do
    it 'deletes the show' do
      show = create(:show)
      expect { delete :destroy, id: show.id }.to change { Show.count }.by(-1)
    end
  end
end
