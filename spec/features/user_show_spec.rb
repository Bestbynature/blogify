require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless

    # Create a user and some posts for testing
    @user = FactoryBot.create(:user)
    @posts = FactoryBot.create_list(:post, 3, author: @user)
  end

  it 'displays user information' do
    visit user_path(@user)

    expect(page).to have_css("img[src='https://source.unsplash.com/glRqyWJgUeY']")
    expect(page).to have_content('Test User')
    expect(page).to have_content("Number of Posts: 3")
    expect(page).to have_content('Test User bio')
  end

  it 'displays first 3 posts of the user' do
    visit user_path(@user)

    @posts.each_with_index do |post, index|
      expect(page).to have_content("Post ##{index + 1}")
      expect(page).to have_content(post.text)
      expect(page).to have_content("Comments: #{post.comments.count}")
      expect(page).to have_content("Likes: #{post.likes_counter}")
      expect(page).to have_link('Show this post', href: user_post_path(@user, post))
    end
  end

  it 'redirects to the post show page when clicking on a post' do
    visit user_path(@user)
  
    @posts.each do |post|
      post_container = find("div[data-post-id='#{post.id}']")
      within(post_container) do
        click_link "Show this post", exact_text: true
      end
  
      # Adding a short wait time to ensure the click event takes effect
      sleep 1
  
      expect(current_path).to eq(user_post_path(@user, post))
      visit user_path(@user) # Go back to the user show page for the next iteration
    end
  end
  
  
  it 'redirects to the user posts index page when clicking "View all posts"' do
    visit user_path(@user)
  
    find("a[data-view-all-posts='true']").click
  
    # Adding a short wait time to ensure the click event takes effect
    sleep 1
  
    expect(current_path).to eq(user_posts_path(@user))
  end
  
  
  
end
