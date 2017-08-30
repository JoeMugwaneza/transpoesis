class Category < ApplicationRecord
  has_many :recommends
  has_many :users, through: :recommends
  
  has_many :post_categories
  has_many :posts, through: :post_categories
  
end
