require 'rails_helper'

RSpec.describe Api::V1::ChatroomsController, type: :request do

  let(:current_user){
    create(:user)
  }

  let(:another_user){
    create(:user, email: "anotheruser@mail.com")
  }

  let(:token){
    current_user.create_new_auth_token
  }
  
  def expected
    {
      id: 1,
      last_message: {
        id: 1,
        body: "Hi",
        user_id: 2,
      },
      other_user: {
        id: 2,
        name: another_user.name,
        image: nil,
      }
    }
  end

  before(:each) do
    current_user
    another_user
    token
    chatroom = Chatroom::create()
    chatroom.chatroom_users.create(user: current_user)
    chatroom.chatroom_users.create(user: another_user)
    chatroom.messages.create(body: "Hi", user: another_user)
  end

  describe "#index" do

    it "fetches chats" do
       
        @expected = [expected].to_json
        get api_v1_chatrooms_path, headers: token
        response.body.should == @expected
    end

  end


  describe "#show" do

    it "fetches chat", focus: true do
        @expected = expected.to_json
        get api_v1_chatroom_path, 
          headers: token,
          params: {
            user_id: another_user.id
          }
        response.body.should == @expected
    end

  end

end
