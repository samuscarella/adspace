class AddCategoriesToInfoBomb < ActiveRecord::Migration
  def change
    add_column :info_bombs, :category_id, :integer, array: true, default: []
  end
end
