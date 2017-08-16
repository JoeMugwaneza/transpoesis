class AddReviewToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :review, :string, default: false
  end
end
