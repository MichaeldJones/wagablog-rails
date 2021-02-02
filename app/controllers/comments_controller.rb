class CommentsController < ApplicationController

  before_action :find_post
  before_action :find_comment, only: [:update, :edit, :destroy]

  def create

    redirect_to post_path(@post) unless user_signed_in?

    @comment = @post.comments.create(comment_params)

    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post)
    else
      flash.now[:danger] = "error"
    end
    
  end

  def destroy

    if @comment.user == current_user || current_user.try(:admin?)
      @comment.destroy
    end
    redirect_to post_path(@post)
  end

  def edit
    redirect_to @post unless @comment.user == current_user
  end

  def update

    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user, :comment, :user_id)
  end
end
