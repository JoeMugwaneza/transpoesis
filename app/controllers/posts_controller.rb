class PostsController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  
  def index
    @posts = Post.all
    @post = Post.new
  end

  def show 
    find_post
  end

  def new
    @post = Post.new
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
    redirect_to root_path

  end

  private

    def post_params
      params.require(:post).permit(:name, :body, :user_id)
    end

    def find_post
      @post = Post.find_by(id: params[:id])
    end
end
