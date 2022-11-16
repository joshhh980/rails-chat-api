class ChatroomChannel < ApplicationCable::Channel

  def subscribed
    reject if params[:chatroom_id].blank?
    chatroom = Chatroom.find(params[:chatroom_id])
    stream_for chatroom
  end

  def speak data
    chatroom = Chatroom.find(data["chatroom_id"])
    broadcast_to chatroom, message: data["message"]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
