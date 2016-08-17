class AddForeignKeysToCategoriesAndPosts < ActiveRecord::Migration
  def change
    add_foreign_key :posts, :categories
    add_foreign_key :categories, :posts
  end
end
