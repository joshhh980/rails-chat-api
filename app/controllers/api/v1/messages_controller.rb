module Api
  module V1
    class MessagesController < ApplicationController
      def create
        user_id = params[:user_id]
        user = User.find(user_id)
        chatroom = Chatroom.between(current_user, user)
        if !chatroom
          chatroom = Chatroom.create
          chatroom.chatroom_users.create({ user_id: user_id })
          chatroom.chatroom_users.create({ user_id: current_user.id })
        end
        @message = chatroom.messages.create({
          user_id: current_user.id,
          body: params[:body],
        })
        UserChannel.broadcast_to(user,
                                 message: @message,
                                 user_id: user.id)
        ChatroomsChannel.broadcast_to("chatrooms-#{user.id}",
                                      chatroom: render_to_string(partial: "api/v1/chatrooms/achatroom", locals: { chatroom: chatroom, other_user: user }),
                                      user_id: user.id)
        render "api/v1/messages/show.json.jbuilder"
      end

      def read
        user_id = params[:user_id]
        user = User.find(user_id)
        chatroom = Chatroom.between(current_user, user)
        chatroom.unread_messages
          .where(user_id: user.id)
          .update({ read: true })
      end
    end
  end
end
