class ChangeShowDescType < ActiveRecord::Migration
  def change
    change_column :shows, :description, :text
  end
end
