class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :body, :number_to, :send_at_datetime
end
