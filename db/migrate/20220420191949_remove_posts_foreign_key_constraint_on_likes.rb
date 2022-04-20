class RemovePostsForeignKeyConstraintOnLikes < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :likes, :posts if foreign_key_exists?(:likes, :posts)
  end
end
