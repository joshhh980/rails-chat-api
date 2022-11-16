require 'rails_helper'

RSpec.describe ChatroomChannel, type: :channel do
  


  it "sends message" do
    chatroom = Chatroom.create()
    subscribe chatroom_id: chatroom.id
    expect {
      perform :speak, message: 'Body', chatroom_id: chatroom.id
    }.to have_broadcasted_to(chatroom).with({
      message: "Body"
    })
  end

end
