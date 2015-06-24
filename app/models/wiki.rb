class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  belongs_to :user
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
