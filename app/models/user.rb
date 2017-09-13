class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_picture, ProfilePictureUploader

  scope :users_with_posts, -> {joins("INNER JOIN posts ON posts.user_id = users.id AND posts.published = 't'").distinct}

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


  include FriendlyId

   friendly_id :full_name, use: [:slugged, :finders]


  def should_generate_new_friendly_id?
    full_name || super
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  include UsersHelper


  def category_tokens=(ids)
    self.category_ids = ids 
  end


   def reset_password; nil; end

  def reset_password=(value)
    return nil if value.blank?
    self.password = value
    self.password_confirmation = value
  end

   rails_admin do
      configure :reset_password
      list do
        include_fields :first_name, :last_name, :email, :admin, :profile_picture, :enabled
      end
      edit do
       exclude_fields :id, :slug, :encrypted_password, :created_at, :updated_at, :remember_created_at, :sign_in_count , :current_sign_in_at, :reset_password_token, :reset_password_sent_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip
       include_fields :reset_password
      end
  end
end
