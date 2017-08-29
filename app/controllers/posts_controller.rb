class PostsController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  
  def index
    if params[:sort]
      @posts = Category.find_by(id: params[:sort].to_i).posts
    else
      @posts = Post.where('review =?', true)
    end

    @recent_posts = Post.where('review =?', true).in_order.endmost(10)
  end

  def show 
    @user = User.find_by(id: params[:id])
    @post = Post.find_by(id: params[:id])

    @recent_posts = Post.where('review =?', true).in_order.endmost(10)
    @post.punch(request)
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|

      if @post.save
        format.html {redirect_to @post, notice: 'Post Created'}
        format.json {render :show, status, :created, location: @post}
        format.js
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  def edit
    find_post
  end

  def update
    find_post
    if @post.update(post_params)
      flash[:success] = "Successfully Updated"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    find_post
    @post.destroy
    flash[:warning] = "Post Was Deleted"
    redirect_to root_url

  end


  def like
    @post = Post.find_by(id: params[:id])
    @post.liked_by current_user

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js { render layout: false }
    end
  end

  def unlike
    @post = Post.find_by(id: params[:id])
    @post.unliked_by current_user

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js { render layout: false }
    end
  end

  private

    def post_params
      params.require(:post).permit(:name, :body, :user_id, category_ids: [])
    end

    def find_post
      @post = Post.find_by(id: params[:id])
    end
end
