class ApplicationMailbox < ActionMailbox::Base
  # route any mails from comment-<id>@reply.example.com to the CommentsMailbox
  routing /comment-\d+/i => :comments
end
