class Public::UsersController < ApplicationController
before_action :authenticate_user!
before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
     @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
    @post = Post.new
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = 'ユーザーを削除しました。'
      redirect_to :root
  end

 # フォロー機能
   def following
    @title = "フォロー"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
   end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
  
 
end