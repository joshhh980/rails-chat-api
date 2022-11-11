require 'rails_helper'

RSpec.describe Api::V1::ChatroomsController, type: :request do

  let(:current_user){
    create(:user)
  }
  
  describe "#index" do

    it "fetches chats" do
        current_user
        token = current_user.create_new_auth_token
        another_user = create(:user, email: "anotheruser@mail.com")
        chatroom = Chatroom::create()
        chatroom.chatroom_users.create(user: current_user)
        chatroom.chatroom_users.create(user: another_user)
        chatroom.messages.create(body: "Hi", user: another_user)
        @expected = [{
          id: 1,
          last_message: {
            id: 1,
            body: "Hi",
            user_id: 2,
          },
          other_user: {
            id: 2,
            name: another_user.name
          }
        }].to_json
        get api_v1_chatrooms_path, headers: token
        response.body.should == @expected
    end

  end

end
