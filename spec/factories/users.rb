FactoryBot.define do
    factory :user do
      name { 'Test User' }
      photo { 'https://source.unsplash.com/glRqyWJgUeY' }
      bio { 'Test User bio' }
    end
  end
  