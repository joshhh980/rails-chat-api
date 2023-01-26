require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :request do

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
        body: "Hello",
        user_id: 1,
    }
  end

  before(:each) do
    current_user
    another_user
    token
  end

  describe "#create" do

    context "chatroom" do

      it "creates message" do
          chatroom = Chatroom::create()
          chatroom.chatroom_users.create(user: current_user)
          chatroom.chatroom_users.create(user: another_user)
          @expected = expected.to_json
          post api_v1_messages_path, 
              headers: token,
              params: {
                  body: "Hello",
                  user_id: another_user.id,
              }
            expect(response.body).to eq(@expected)
      end

    end

    context "no chatroom" do

      it "creates chatroom and message" do
          @expected = expected.to_json
          post api_v1_messages_path, 
              headers: token,
              params: {
                  body: "Hello",
                  user_id: another_user.id,
              }
          expect(Chatroom.count).to eq(1)
          expect(response.body).to eq(@expected)
      end

    end

  end

end
