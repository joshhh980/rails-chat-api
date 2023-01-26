module Api
  module V1
    class MessagesController < ApplicationController
      def create
        chatroom = Chatroom.joins(:chatroom_users)
          .where("chatroom_users.user_id": [current_user.id, params[:user_id]]).first
        if !chatroom
          chatroom = Chatroom.create
          chatroom.chatroom_users.create({ user_id: params[:user_id] })
          chatroom.chatroom_users.create({ user_id: current_user.id })
        end
        @message = chatroom.messages.create({
          user_id: current_user.id,
          body: params[:body],
        })
        user = User.find(params[:user_id])
        UserChannel.broadcast_to(user,
                                     message: @message,
                                     user_id: user.id)
        render "api/v1/messages/show.json.jbuilder"
      end
    end
  end
end
