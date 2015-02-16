class User < ActiveRecord::Base
  has_many :messages

  validates_format_of :phone_number, :with => /\+\d{11}/, :on => :create
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
