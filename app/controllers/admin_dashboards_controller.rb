class AdminDashboardsController < ApplicationController
  def admin
    # @disable_sidebar = true
    @user = User.find_by(id: params[:id])

    @admin = current_user.admin
    @recent_posts = Post.published.in_order.endmost(5)
  end
end
