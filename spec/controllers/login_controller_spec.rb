require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'get index' do
    before(:each) do
      Setting.authentication.update_attributes(bool: true)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'expires the existing session' do
      expect(session[:authenticated]).to eq(nil)
      get :index
      expect(session[:authenticated]).to eq(false)

      session[:authenticated] = true
      get :index
      expect(session[:authenticated]).to eq(false)
    end
  end

  describe 'post login' do
    it 're-renders the index template if the password is wrong' do
      Setting.authentication.update_attributes(str: 'right', bool: true)

      get :index
      expect(response).to render_template(:index)
      expect(session[:authenticated]).to eq(false)

      post :login, auth: { password: 'wrong' }
      expect(response).to render_template(:index)
      expect(session[:authenticated]).to eq(false)
    end

    it 'redirects to home if password is right' do
      Setting.authentication.update_attributes(str: 'right', bool: true)

      get :index
      expect(response).to render_template(:index)
      expect(session[:authenticated]).to eq(false)

      post :login, auth: { password: 'right' }
      expect(response).to redirect_to('/')
      expect(session[:authenticated]).to eq(true)
    end
  end
end
