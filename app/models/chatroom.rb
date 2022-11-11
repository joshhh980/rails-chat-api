class Chatroom < ApplicationRecord
    has_many :chatroom_users
    has_many :messages

    def other_user current_user
        chatroom_users.where
            .not(user: current_user)
            .first
            .user
    end
end
