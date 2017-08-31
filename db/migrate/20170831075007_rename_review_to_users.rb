class RenameReviewToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :review, :published
  end
end