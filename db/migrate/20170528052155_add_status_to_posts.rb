class AddStatusToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :status, :string, :default => "draft"
  end
end
