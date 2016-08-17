class CreateInfoBombs < ActiveRecord::Migration
  def change
    create_table :info_bombs do |t|
      t.string :title
      t.text :content
      t.string :image
      t.string :video
      t.string :url
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
