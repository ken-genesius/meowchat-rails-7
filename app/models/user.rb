class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :all_except, ->(user) { where.not(id: user) }
  has_many :messages
  has_many :chatroommembers

  after_create_commit { broadcast_append_to "users" }

  def email_required?
    false
  end
end
