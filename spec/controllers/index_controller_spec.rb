require 'rails_helper'

RSpec.describe IndexController, type: :controller do
  describe 'authorization filter' do
    it 'redirects to /login unless session is set up' do
      Setting.authentication.update_attributes(bool: true)
      get :index
      expect(response).to redirect_to(:login)

      session[:authenticated] = true
      get :index
      expect(response).to render_template(:index)
    end

    it 'sets the require_auth session variable and caches the result' do
      Setting.authentication.update_attributes(bool: true)
      expect(session[:require_auth]).to eq(nil)
      get :index
      expect(session[:require_auth]).to eq(true)
      Setting.authentication.update_attributes(bool: false)
      get :index
      expect(session[:require_auth]).to eq(true)
    end
  end

  describe 'get index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
