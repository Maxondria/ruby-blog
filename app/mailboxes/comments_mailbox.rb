class CommentsMailbox < ApplicationMailbox
  def process
    return if user.nil? || parent_comment.nil?

    comment =
      user.comments.create!(
        content: mail.decoded,
        parent: parent_comment,
        post: parent_comment.post,
      )
  end

  private

  def user
    @user ||= User.find_by(email: mail.from)
  end

  def parent_comment
    to = mail.to.find { |s| s.match /comment-\d+/ }
    comment_id = to.match(/comment-(?<comment_id>\d+)/i)[:comment_id]
    @comment ||= Comment.find!(comment_id)
  end
end
