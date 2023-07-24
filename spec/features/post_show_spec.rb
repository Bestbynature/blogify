# spec/features/post_show_spec.rb
require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature, js: true do
  before do
    Capybara.current_driver = :selenium_chrome_headless

    # Create a user, post, and comments for testing
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, author: @user)
    @comments = FactoryBot.create_list(:comment, 5, post: @post, user: @user)
  end

  it 'displays the post details' do
    visit user_post_path(@post.author, @post)

    expect(page).to have_content("Post ##{@post.id} by #{@user.name}")
    expect(page).to have_content("Comments: 5")
    expect(page).to have_content("Likes: 0")
    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.text)
  end

  it 'displays comments and comment details' do
    visit user_post_path(@post.author, @post)

    @comments.each do |comment|
      expect(page).to have_content("#{comment.user.name}:#{comment.text}")
      expect(page).to have_link('Edit', href: edit_user_post_comment_path(@post.author, @post, comment))
      expect(page).to have_link('Delete', href: user_post_comment_path(@post.author, @post, comment))
    end
  end
end
