class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :user_id, scope: :post_id


  
  rails_admin do
    list do
      exclude_fields :created_at, :updated_at, :id
      end
      edit do
       exclude_fields :created_at, :updated_at, :id
      end
  end
end
