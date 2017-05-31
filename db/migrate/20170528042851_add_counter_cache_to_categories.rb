class AddCounterCacheToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :posts_count, :integer, default: 0
    add_index :posts, :category_id
  end
end
