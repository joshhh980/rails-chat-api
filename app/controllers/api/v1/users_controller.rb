module Api
    module V1 
        class UsersController < ApplicationController
            def index
                @users = User.where.not id: current_user.id
                render "api/v1/users/index.json.jbuilder"
            end
        end
    end
end