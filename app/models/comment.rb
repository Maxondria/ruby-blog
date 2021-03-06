# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id
  has_many :likes, as: :likeable, dependent: :destroy

  scope :with_user, -> { includes(:user) }
  scope :by_most_recent, -> { with_user.order(id: :desc) }
  scope :top_level, -> { with_user.by_most_recent.where(parent_id: nil) }
end
