class AdminDashboardsController < ApplicationController
  def admin
    # @disable_sidebar = true
    @user = User.find_by(id: params[:id])

    @admin = current_user.admin

    @pending_posts = Post.all.pending
    @published_posts = Post.all.published

    @users = User.all

    @recent_posts = Post.published.in_order.endmost(5)

    
  end
end
