module Api
    module V1 
        class ChatroomsController < ApplicationController
            def index
                @chatrooms = Chatroom.all
                render "api/v1/chatrooms/index.json.jbuilder"
            end

            def show
                @chatroom = Chatroom.joins(:chatroom_users)
                    .where("chatroom_users.user_id": [current_user.id, params[:user_id]]).first
                puts @chatroom.id
                render "api/v1/chatrooms/show.json.jbuilder"
            end

        end
    end
end