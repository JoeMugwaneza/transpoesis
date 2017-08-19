class AddColumnToPost < ActiveRecord::Migration[5.1]
  def change
     
    add_column :posts, :cached_votes_up, :integer, :default => 0
    add_column :posts, :cached_votes_down, :integer, :default => 0
    add_column :posts, :cached_votes_score, :integer, :default => 0
    add_index  :posts, :cached_votes_up
    add_index  :posts, :cached_votes_down
    add_index  :posts, :cached_votes_score
  end
end
