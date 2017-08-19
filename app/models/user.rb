class User < ApplicationRecord
  has_secure_password
  has_many :posts, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
    
  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name


end
