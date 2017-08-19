class Feedback < ApplicationRecord
  belongs_to :post, optional: true
  
end
