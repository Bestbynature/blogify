class LikesController < ApplicationController
  before_action :authenticate_user!
  # def create
  #   @post = Post.find(params[:post_id])
  #   @user = current_user
  #   @like = Like.new(user_id: @user.id, post_id: @post.id)

  #   return unless @like.save

  #   redirect_to user_posts_path(@post.id, @post)
  # end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user_id: @user.id, post_id: @post.id)
    respond_to do |format|
      if @like.save
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Post was successfully liked.' }
      else
        format.html { redirect_to user_post_path(@post.author, @post), alert: 'Error while liking the post.' }
      end
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.find_by(user_id: @user.id, post_id: @post.id)

    if @like&.destroy
      # Decrement the likes_counter of the post
      @post.decrement!(:likes_counter)

      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post) }
        format.js # This will render `destroy.js.erb`
      end
    else
      redirect_to user_post_path(@user, @post), alert: 'Error while unliking the post.'
    end
  end

  # def destroy
  #   @post = Post.find(params[:post_id])
  #   @user = current_user
  #   @like = Like.find_by(user_id: @user.id, post_id: @post.id)

  #   if @like.destroy
  #     # Decrement the likes_counter of the post
  #     @post.decrement!(:likes_counter)
  #     # respond_to do |format|
  #     #   format.html { redirect_to user_post_path(@user.id, @post.id) }
  #     #   format.js   # This will render `destroy.js.erb`
  #     # end
  #   end
  # end
end
