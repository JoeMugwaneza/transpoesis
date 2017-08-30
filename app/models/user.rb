class User < ApplicationRecord
  has_secure_password
  mount_uploader :profile_picture, ProfilePictureUploader
  
  has_many :posts, :dependent => :destroy
  # has_many :feedbacks, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  
  has_many :recommends
  has_many :categories, through: :recommends
   
  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name

  acts_as_voter

  include UsersHelper


  def category_tokens=(ids)
    self.category_ids = ids 
  end

end
