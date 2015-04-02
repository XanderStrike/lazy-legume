require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  describe 'get index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
