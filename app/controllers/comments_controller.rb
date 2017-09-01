class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end


  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save

    respond_to do |format|
      format.html {redirect_to @post}
      format.js
    end
  end


  def edit
    find_comment
  end

  def update
    if @comment.update(comment_params)
      flash[:info] = "Comment Updated"
      redirect_to @comment.post
    else 
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment Deleted" }
      format.js { render layout: false }
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end

    def find_comment
      @comment = @post.comments.find_by[id: params[:id]]
    end


end
