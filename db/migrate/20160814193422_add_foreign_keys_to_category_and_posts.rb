class AddForeignKeysToCategoryAndPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :category, index: true
    add_reference :categories, :posts, index: true
  end
end
