module Api
  module V1
    class CommentsController < ApplicationController
      include Swagger::Blocks

      swagger_path '/api/v1/posts/{post_id}/comments' do
        parameter do
          key :name, :post_id
          key :in, :path
          key :description, 'ID of the post'
          key :required, true
          key :type, :integer
          key :format, :int64
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        operation :get do
          key :summary, 'Get comments for a post'
          key :tags, ['Comments']
          response 200 do
            key :description, 'List of comments'
            schema do
              key :type, :array
              items do
                key :type, :object
                property :id do
                  key :type, :integer
                  key :format, :int64
                end
                property :text do
                  key :type, :string
                end
                property :user_id do
                  key :type, :integer
                  key :format, :int64
                end
                property :post_id do
                  key :type, :integer
                  key :format, :int64
                end
              end
            end
          end
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        operation :post do
          key :summary, 'Create a comment for a post'
          key :tags, ['Comments']
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        parameter do
          key :name, :post_id
          key :in, :path
          key :description, 'ID of the post'
          key :required, true
          key :type, :integer
          key :format, :int64
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        parameter do
          key :name, :comment
          key :in, :body
          key :description, 'Comment object'
          key :required, true
          schema do
            key :type, :object
            property :text do
              key :type, :string
            end
          end
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        response 201 do
          key :description, 'Comment created successfully'
          schema do
            key :type, :object
            property :id do
              key :type, :integer
              key :format, :int64
            end
            property :text do
              key :type, :string
            end
            property :user_id do
              key :type, :integer
              key :format, :int64
            end
            property :post_id do
              key :type, :integer
              key :format, :int64
            end
            property :created_at do
              key :type, :string
              key :format, :date_time
            end
            property :updated_at do
              key :type, :string
              key :format, :date_time
            end
          end
        end
      end

      swagger_path '/api/v1/posts/{post_id}/comments' do
        response 422 do
          key :description, 'Unprocessable Entity'
          schema do
            key :type, :object
            key :properties, {
              errors: {
                type: :array,
                items: {
                  type: :string
                }
              }
            }
          end
        end
      end
    end
  end
end
