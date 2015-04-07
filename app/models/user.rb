class User < ActiveRecord::Base

  has_many :messages

  validates_format_of :phone_number, :with => /\+\d{11}/, :on => :create

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
end
