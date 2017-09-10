class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_picture, ProfilePictureUploader

  has_many :posts, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :recommends, :dependent => :destroy
  has_many :categories, through: :recommends
   
  validates_uniqueness_of :email, :message => 'your email is taken'
  
  validates_presence_of :first_name, :last_name, :message => 'This field cannot be blank'
  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
  validates :password, :confirmation   => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? } 



  acts_as_voter

  include UsersHelper


  def category_tokens=(ids)
    self.category_ids = ids 
  end

end
