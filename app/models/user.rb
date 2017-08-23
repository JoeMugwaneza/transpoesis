class User < ApplicationRecord
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
    
  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name

  acts_as_voter


  def favorite(post)
    favorites.find_or_create_by(post: post)
  end

  def unfavorite(post)
    favorites.where(post: post).destroy_all

    post.reload
  end


  def favorited?(post)
    favorites.find_by(post_id: post.id).present?
  end

end
