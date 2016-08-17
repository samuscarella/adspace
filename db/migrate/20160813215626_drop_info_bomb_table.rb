class DropInfoBombTable < ActiveRecord::Migration
  def change
    drop_table :info_bombs
  end
end
