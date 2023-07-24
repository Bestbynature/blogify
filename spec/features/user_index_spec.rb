require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless

    @users = []
    @users << User.create(name: 'User1', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'User1 bio', posts_counter: 0)
    @users << User.create(name: 'User2', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'User2 bio', posts_counter: 0)
    @users << User.create(name: 'User3', photo: 'https://source.unsplash.com/glRqyWJgUeY', bio: 'User3 bio', posts_counter: 0)
  end

  it 'displays username, profile picture, and number of posts for each user' do
    visit users_path

    @users.each do |user|
      user_element = find("#user-#{user.id}")
      expect(user_element).to have_content(user.name)
      expect(user_element).to have_css("img[src='#{user.photo}']")
      expect(user_element).to have_content("Number of Posts: #{user.posts_counter}")
    end
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    @users.each do |user|
      user_element = find("#user-#{user.id}")
      within(user_element) do
        click_link 'Show this user'
      end

      expect(page).to have_current_path(user_path(user))
      visit users_path 
    end
  end
end
