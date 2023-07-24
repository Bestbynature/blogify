# spec/factories/comments.rb
FactoryBot.define do
    factory :comment do
      text { 'Test comment' }
      association :user
      association :post
    end
  end
  