class Chatroom < ApplicationRecord
  has_many :chatroom_users
  has_many :messages

  def other_user(current_user)
    chatroom_users.where
      .not(user: current_user)
      .first
      .user
  end

  def self.between(user, other_user)
    chatrooms = Chatroom.joins(:chatroom_users)
      .where("chatroom_users.user_id": user.id)
    chatroom_user = chatrooms.map { |chatroom| chatroom.chatroom_users.where(user_id: other_user.id).first }[0]
    chatroom = chatroom_user ? chatroom_user.chatroom : nil
  end

  def unread_messages
    messages.unread
  end

  def unread_messages_count
    unread_messages.count
  end

  def other_user_unread_messages current_user
    unread_messages.where(user_id: other_user(current_user))
  end

end
