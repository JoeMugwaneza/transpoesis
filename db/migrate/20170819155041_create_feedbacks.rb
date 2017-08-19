class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.text :content
      t.string :post_id
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
