class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.likes_counter += 1
    @post.save

    redirect_to @post, notice: 'Post liked!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
