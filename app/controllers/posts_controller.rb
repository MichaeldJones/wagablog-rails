class PostsController < ApplicationController

  before_action :find_post, only: [:show, :update, :edit, :destroy]

  def index
    @posts = Post.search(params[:search])
  end

  def new
    redirect_to root_path unless current_user.try(:admin?)
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy

    if current_user.try(:admin?)
      @post.destroy
    end
    
    redirect_to posts_path
  end

  def show
  end

  def edit
    redirect_to @post unless current_user.try(:admin?)
  end

  def update

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :search)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
