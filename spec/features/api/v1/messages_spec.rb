require "rails_helper"

RSpec.shared_examples "broadcast" do
  it "broadcasts to user chatrooms channel" do
    chatroom = Chatroom.first
    expect(ChatroomsChannel).to have_received(:broadcast_to).with("chatrooms-#{another_user.id}", {
      :user_id => another_user.id,
      :chatroom => chatroom,
    })
  end

  it "broadcasts to user" do
    message = Message.first
    expect(UserChannel).to have_received(:broadcast_to).with(another_user, {
      :user_id => another_user.id,
      :message => message,
    })
  end

end

RSpec.describe Api::V1::MessagesController, type: :request do
  let(:current_user) {
    create(:user)
  }

  let(:another_user) {
    create(:user, email: "anotheruser@mail.com")
  }

  let(:token) {
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

  def make_request
    post api_v1_messages_path,
         headers: token,
         params: {
           body: "Hello",
           user_id: another_user.id,
         }
  end

  describe "#create" do
    before(:each) do
      allow(UserChannel).to receive(:broadcast_to)
      allow(ChatroomsChannel).to receive(:broadcast_to)
      @expected = expected.to_json
    end

    context "chatroom" do

      before(:each) do
        chatroom = Chatroom::create()
        chatroom.chatroom_users.create(user: current_user)
        chatroom.chatroom_users.create(user: another_user)
        make_request
      end

      it "creates message" do

        expect(response.body).to eq(@expected)
      end

      include_examples "broadcast", "offline"

    end

    context "no chatroom" do
      before(:each) do
        make_request
      end

      it "creates chatroom and message" do
        expect(Chatroom.count).to eq(1)
        expect(ChatroomUser.count).to eq(2)
        expect(response.body).to eq(@expected)
      end

      include_examples "broadcast", "offline"
    end
  end
end
