require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'displays placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Users')
    end
  end

  describe 'GET #show' do
    let(:user) { User.create(name: 'John Doe', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'Teacher from Mexico', posts_counter: 0) }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'displays placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('Name')
    end
  end
end