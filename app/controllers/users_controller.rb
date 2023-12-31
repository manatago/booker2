class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def post_count
   @user = User.find(params[:id])
   @date = params[:date]
  end

  def index
    @users = User.all
    if request.path.split('/')[3]
      # user_id = request.path.split('/')[2].to_i
      if request.path.split('/')[3] == 'follows'
        @users = User.find(params[:id]).follow_members
        @title = 'follows'
      elsif request.path.split('/')[3]=='followers'
        @users = User.find(params[:id]).follower_members
        @title = 'followers'
      end
    end
    @book = Book.new
  end

  def edit
    if current_user.id.to_i != params[:id].to_i
      redirect_to user_path(current_user)
    end
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
