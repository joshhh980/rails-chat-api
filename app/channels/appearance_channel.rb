class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"
  end

  def appear
    broadcast "appear", current_user.id, "online"
  end

  def unsubscribed
    broadcast "away", current_user.id, "offline"
  end

  private
    def broadcast action, user_id, state
      current_user.update(status: state)
      users = User.all
      ActionCable.server.broadcast("appearance", 
        action: action,
        user_id: user_id,
      )
    end

end
