class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = @post.comments
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit; end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = params[:user_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_url(@post.author, @post), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: user_post_comment_path(@post.author, @post, @comment) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = if params[:id]
                 @post.comments.find(params[:id])
               else
                 @post.comments.build
               end
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
