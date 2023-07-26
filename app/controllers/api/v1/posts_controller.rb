module Api
  module V1
    class PostsController < ApplicationController
      include Swagger::Blocks

      swagger_path '/api/v1/posts' do
        operation :get do
          key :summary, 'Get all posts'
          key :tags, ['Posts']
        end
      end

      swagger_path '/api/v1/posts' do
        response 200 do
          key :description, 'List of posts'
          schema do
            key :type, :array
            items do
              key :type, :object
              property :id do
                key :type, :integer
                key :format, :int64
              end
              property :title do
                key :type, :string
              end
              property :text do
                key :type, :string
              end
              property :comments_counter do
                key :type, :integer
                key :format, :int64
              end
              property :likes_counter do
                key :type, :integer
                key :format, :int64
              end
            end
          end
        end
      end
    end
  end
end
