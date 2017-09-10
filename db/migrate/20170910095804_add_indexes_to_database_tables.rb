class AddIndexesToDatabaseTables < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, :user_id
    add_index :posts, :published
    add_index :posts, :updated_at
  end
end
