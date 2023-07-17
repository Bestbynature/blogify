require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/'
      expect(response).to have_http_status(:success)
    end

    it 'displays appropriate placeholder' do
      get '/users/'
      expect(response.body).to include('Here is a list of all the users stored in the database')
    end

    it 'renders the appropriate template' do
      get '/users/'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/:user_id'
      expect(response).to have_http_status(:success)
    end

    it 'displays appropriate placeholder' do
      get '/users/:users_id'
      expect(response.body).to include('This is a particular user with the given id')
    end

    it 'renders the appropriate template' do
      get '/users/:user_id'
      expect(response).to render_template(:show)
    end
  end
end
