class User < ActiveRecord::Base
  has_many :messages

  validates_format_of :phone_number, :with => /\+\d{11}/, :on => :create
end
