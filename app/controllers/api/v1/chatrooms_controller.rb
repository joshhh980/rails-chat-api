module Api
  module V1
    class ChatroomsController < ApplicationController
      def index
        @chatrooms = Chatroom.joins(:chatroom_users)
          .where("chatroom_users.user_id": current_user.id)
        render "api/v1/chatrooms/index.json.jbuilder"
      end

      def show
        user = User.find(params[:user_id])
        @chatroom = Chatroom.between(current_user, user)
        render "api/v1/chatrooms/show.json.jbuilder"
      end
    end
  end
end
