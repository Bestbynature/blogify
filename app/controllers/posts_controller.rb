class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_user
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).paginate(page: params[:page], per_page: 3)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.author_id = params[:user_id]

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_post_url(@post.author, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_posts_path(@post.author), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @post = Post.find(params[:id])
    @post.increment!(:likes_counter)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
