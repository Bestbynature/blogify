require 'swagger_helper'

RSpec.describe 'API', type: :request do
  path '/api/v1/posts' do
    get 'Get all posts' do
      tags 'Posts'
      produces 'application/json'

      response '200', 'List of posts' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer, format: :int64 },
                   title: { type: :string }
                 }
               }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :integer

    get 'Get comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :post_id, in: :path, type: :integer

      response '200', 'List of comments' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer, format: :int64 },
                   text: { type: :string },
                   user_id: { type: :integer, format: :int64 }
                 }
               }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :integer

    post 'Create a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Comment created' do
        schema type: :object,
               properties: {
                 id: { type: :integer, format: :int64 },
                 text: { type: :string },
                 user_id: { type: :integer, format: :int64 }
               }
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        schema type: :object,
               properties: {
                 errors: { type: :array, items: { type: :string } }
               }
        run_test!
      end
    end
  end
end