class AddPostsCountToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :posts_count, :integer, default: 0
  end
end
