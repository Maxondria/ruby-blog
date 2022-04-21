class CommentMailer < ApplicationMailer
  def new_comment(user, post)
    @user = user
    @post = post
    @comment = @post.comments.last

    mail(
      to: @user.email,
      from: "comment-#{@comment.id}@reply.example.com",
      subject: "New comment on #{@post.title}",
    )
  end
end
