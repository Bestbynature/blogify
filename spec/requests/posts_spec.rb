require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/:user_id/posts/'
      expect(response).to have_http_status(:success)
    end

    it 'returns the appropriate placeholders' do
      get '/users/:user_id/posts'
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'renders the appropriate template' do
      get '/users/:user_id/posts'
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/:user_id/posts/show'
      expect(response).to have_http_status(:success)
    end

    it 'returns the appropriate placeholders' do
      get '/users/:user_id/posts/show'

      expected_content = 'This is a particular post with the given ID out of all ' \
                         'the posts for a given user'

      expect(response.body).to include(expected_content)
    end

    it 'renders the appropriate template' do
      get '/users/:user_id/posts/show'
      expect(response).to render_template(:show)
    end
  end
end
