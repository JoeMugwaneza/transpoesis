class Category < ApplicationRecord
  has_many :recommends
  has_many :users, through: :recommends
  
  has_many :post_categories
  has_many :posts, through: :post_categories
  


  rails_admin do
    list do
      exclude_fields :created_at, :updated_at, :id, :recommends, :post_categories
    end
    edit do
      exclude_fields :created_at, :updated_at, :id, :recommends, :post_categories

    end
  end
end
