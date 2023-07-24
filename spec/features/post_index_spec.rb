# spec/features/user_post_index_spec.rb
require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless

    # Create a user and some posts for testing
    @user = FactoryBot.create(:user)
    @posts = FactoryBot.create_list(:post, 10, author: @user) # Create 10 posts for pagination testing
    # @comment = FactoryBot.create_list(:comment, 3, post: @posts.first, user: @user)
    @posts.each do |post|
        # Create 5 comments for each post
        FactoryBot.create_list(:comment, 3, post: post, user: @user)
      end
    end

  it 'displays the user\'s profile picture' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'displays the user\'s username' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    visit user_posts_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts.count}")
  end

  it 'displays a post\'s title and some of the post\'s body' do
    visit user_posts_path(@user)
    @posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text[0..50]) # Display first 50 characters of the post's body
    end
  end

  it 'displays the first comments on a post and how many comments a post has' do
    visit user_posts_path(@user)
    @posts.each do |post|
      post.comments.first(3).each do |comment| # Display first 5 comments
        expect(page).to have_content("#{comment.user.name}: #{comment.text}")
      end
      expect(page).to have_content("Number of comments: #{post.comments.count}")
    end
  end

  it 'displays how many likes a post has' do
    visit user_posts_path(@user)
    @posts.each do |post|
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    # Assuming you have more than 10 posts (created 10 for pagination testing)
    # You can create additional posts to test the pagination feature
    # e.g., FactoryBot.create_list(:post, 15, author: @user)
    visit user_posts_path(@user)
    expect(page).to have_css("div.pagination")
  end

  it 'redirects to the post show page when clicking on a post' do
    visit user_posts_path(@user)
  
    @posts.first(3).each do |post|
      post_element = find("#post-#{post.id}")

      within(post_element) do
        link = find("a[data-post-id='#{post.id}']", exact_text: 'Show this post')
        link.click
      end
  
      expect(page).to have_current_path(user_post_path(@user, post))
      visit user_posts_path(@user)
    end
  end
end
