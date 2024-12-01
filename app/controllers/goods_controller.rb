class GoodsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    good = current_user.goods.new(post_id: post.id)
    good.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    good = current_user.goods.find_by(post_id: post.id)
    good.destroy
    redirect_to post_path(post)
  end

end
