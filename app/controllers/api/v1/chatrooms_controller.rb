module Api
    module V1 
        class ChatroomsController < ApplicationController
            def index
                @chatrooms = Chatroom.all
                render "api/v1/chatrooms/index.json.jbuilder"
            end
        end
    end
end