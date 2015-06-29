class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  has_many :collaborators, dependent: :destroy
  belongs_to :user
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
