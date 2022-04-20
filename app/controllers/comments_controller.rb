class CommentsController < ApplicationController
  before_action :ensure_current_user, only: %i[create]

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to @comment.post, notice: 'Comment was successfully created.'
    else
      flash.now[:notice] = @comment.errors.full_messages.to_sentence
      render 'posts/show'
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content, :parent_id)
      .merge(post_id: params.fetch(:post_id))
  end
end
