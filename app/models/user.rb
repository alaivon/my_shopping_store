class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders
  has_many :comments

  def admin?
  	is_admin
  end

  def to_admin
  	self.update(is_admin: true)
  end

  def to_normal
  	self.update(is_admin: false)
  end


end
