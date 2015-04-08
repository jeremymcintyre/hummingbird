class User < ActiveRecord::Base
  include BCrypt

  has_many :messages

  validates_format_of :phone_number, :with => /\+\d{11}/, :on => :create

  validates_presence_of :email#, :name, :password_hash
  validates_uniqueness_of :email#, :name, :password_hash

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
