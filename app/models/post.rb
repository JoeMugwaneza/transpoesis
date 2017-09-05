class Post < ApplicationRecord
  # checking where posts is reviewed by admin
  is_impressionable
  scope :published, -> {where(published: true)}
  scope :pending, ->{where(published: false)}

  belongs_to :user, optional: true
  
  has_many :comments, :dependent => :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  # has_many :feedbacks
  has_many :favorites, :dependent => :destroy

  # acts_as_punchable
  acts_as_votable


  def self.in_order
    order(updated_at: :asc)
  end

  def self.recent(n)
    in_order.endmost(n)
  end

  def self.endmost(n)
    all.only(:order).from(all.reverse_order.limit(n), table_name)
  end

  # def update_user
  #   self.update(user_id: 18)
  # end
end
