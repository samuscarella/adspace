class RenamePostsIdToPostId < ActiveRecord::Migration
  def change
    rename_column :categories, :posts_id, :post_id
  end
end
