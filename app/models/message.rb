class Message < ApplicationRecord
    belongs_to :chatroom
    belongs_to :user

    scope :unread, -> { where(read: false) }
    
end
