class FavoritesController < ApplicationController
  before_action :find_post

  def create
    current_user.favorite(@post)

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Added to favorite" }
      format.js { render layout: false }
    end
  end


  def destroy
    current_user.unfavorite(@post)

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Removed to favorite" }
      format.js { render layout: false }
    end
  end


  private

  def find_post
    @post = Post.find(params[:post_id] || params[:id])
  end
end
