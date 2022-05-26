# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  likeable_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_type :string
#
class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: %i[likeable_id likeable_type] }

  belongs_to :user
  belongs_to :likeable, polymorphic: true
end
