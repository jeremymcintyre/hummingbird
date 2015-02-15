class Message < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :body, :to, :send_at_datetime
end
