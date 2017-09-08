class PostsController < ApplicationController
  
  before_action :authorize_user!, except: [:index]
  impressionist :actions=>[:show,:index]
  
  def index
 
  

    if params[:category]
      @posts = Category.find_by(name: params[:category]).posts.published.paginate(:page => params[:page], :per_page => 4).all.order(:updated_at)
    else
      @posts = Post.published.paginate(:page => params[:page], :per_page => 4).all.order(:updated_at)
    end
    @recent_posts = Post.published.in_order.endmost(5)

    @post = Post.find_by(id: params[:approve])

    if params[:approve]
      @post.published = !@post.published

      if @post.published == true
        @post.save
        flash[:info] = "#{@post.name} got admin approval"
        redirect_to authorize_personel_path
      elsif @post.published == false
        @post.save
        flash[:info] = "#{@post.name} disapproved"
        redirect_to authorize_personel_path
      end
    end
    
  end

  def show 
    @user = User.new
    @user = User.find_by(id: params[:id])
    
    @recent_posts = Post.published.in_order.endmost(5)
    # @post.punch(request)

    @post = Post.find_by(id: params[:id])
    impressionist(@post)
  end

  def new
     @disable_sidebar = true
    @post = Post.new
    @categories = Category.all
    @recent_posts = Post.published.in_order.endmost(5)
    @user = User.new
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|

      if @post.save
        format.html {redirect_to @post, notice: 'Poem Created'}
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
    @disable_sidebar = true
    @recent_posts = Post.published.in_order.endmost(5)
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
