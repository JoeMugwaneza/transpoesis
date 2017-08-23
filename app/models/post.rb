class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, :dependent => :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :feedbacks
  has_many :favorites, :dependent => :destroy

  acts_as_punchable
  acts_as_votable
end
