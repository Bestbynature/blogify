class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # @user = User.find(params[:id])
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.create(params.require(:user).permit(:username,:email,:password))
    # redirect_to users_path
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(params.require(:user).permit(:username, :email, :password))
    redirect_to users_path
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :photo, :bio)
  end
end
