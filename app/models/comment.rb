class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  
  rails_admin do
    list do
      exclude_fields :created_at, :updated_at, :id
      end
      edit do
       exclude_fields :created_at, :updated_at, :id
      end
  end
end
