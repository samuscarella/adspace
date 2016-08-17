class AddTitleAndUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :url, :string
  end
end
