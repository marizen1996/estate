class Public:: PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     if @post.save
      flash[:notice] = "You have created successfully."
      redirect_to posts_path
     else
      flash.now[:notice] = "投稿に失敗しました。"
      render :new
     end
  end

  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

   private

  def post_params
    # params.require(:post).permit(:property_name, :image, :caption)
    params.require(:post).permit(:property_name, :caption, images: [] )
  end




end


