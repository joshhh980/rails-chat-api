class ChatroomChannel < ApplicationCable::Channel

  def subscribed
    reject if params[:chatroom_id].blank?
    chatroom = Chatroom.find(params[:chatroom_id])
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
