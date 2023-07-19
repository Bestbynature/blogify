class PostsController < ApplicationController
  # before_action :set_post, only: %i[show edit update destroy]

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
  
  def update
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to user_post_url(@post), notice: 'Post was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @post }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @post = Post.find(params[:id])
    # @post.destroy

    # respond_to do |format|
    #   format.html { redirect_to user_posts_path(@post.author), notice: 'Post was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  def like
    @post = Post.find(params[:id])
    @post.likes_counter += 1
    @post.save

    redirect_to @post, notice: 'Post liked!'
  end
  
  private

  # def set_post
  #   @post = Post.find(params[:id])
  # end

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end

  # def set_user
  #   @user = User.find(params[:user_id])
  #   # @user = @post.author
  # end
end
