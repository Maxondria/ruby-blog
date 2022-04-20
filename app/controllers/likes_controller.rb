class LikesController < ApplicationController
  before_action :ensure_current_user, only: %i[create destroy]

  def create
    @like = current_user.likes.build(like_params)

    if @like.save
      redirect_to posts_path, notice: 'Like was successfully created.'
    else
      redirect_to posts_path, notice: @like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])

    if @like.destroy
      redirect_to posts_path, notice: 'Like was successfully destroyed.'
    else
      redirect_to posts_path, notice: @like.errors.full_messages.to_sentence
    end
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
