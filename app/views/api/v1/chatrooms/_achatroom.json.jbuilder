json.extract! chatroom, :id
if chatroom.messages.last 
    json.last_message do
        json.partial! "api/v1/messages/last_message", message: chatroom.messages.last
    end
end
json.other_user do
    json.partial! "api/v1/users/user", user: chatroom.other_user(other_user)
end
json.unread_messages chatroom.other_user_unread_messages(other_user).count