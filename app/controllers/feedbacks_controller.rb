class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.save

    respond_to do |format|
      format.html {redirect_to @post}
      format.js
    end
  end
  
  def edit
    find_feedback
  end

  def update
    find_feedback
    if @feedback.update(feedback_params)
      flash[:info] = "Feedback Updated"
      redirect_to @post
    else 
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @feedback = @post.feedbacks.find_by(id: params[:id])
    @feedback.destroy
    flash[:warning] = "Feedback Deleted!"
    
    redirect_to post_path(@post)
  end


  private

    def feedback_params
      params.require(:feedback).permit(:content, :post_id, :user_id)
    end

    def find_feedback
      @feedback = @post.feedbacks.find_by[id: params[:id]]
    end

end
