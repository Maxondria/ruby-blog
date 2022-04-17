class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :ensure_current_user

  def index
    @posts = current_user.posts
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html do
          redirect_to post_url(@post), notice: 'Post was successfully created.'
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html do
          redirect_to post_url(@post), notice: 'Post was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html do
        redirect_to posts_url, notice: 'Post was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params.fetch(:id))
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
