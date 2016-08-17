class AddUrlImageColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :url_image, :string
  end
end
