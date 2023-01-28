class ChatroomsChannel < ApplicationCable::Channel

    def subscribed
      stream_for "chatrooms-#{current_user.id}"
    end
  
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end
  
  end
  