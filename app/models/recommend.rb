class Recommend < ApplicationRecord
  belongs_to :user
  belongs_to :category




  rails_admin do
    list do
      exclude_fields :created_at, :updated_at, :id
      end
      edit do
       exclude_fields :created_at, :updated_at, :id
      end
  end
end
