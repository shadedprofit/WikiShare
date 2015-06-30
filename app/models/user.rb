class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :collaborators, dependent: :destroy
  has_many :wikis, through: :collaborators
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end
end
