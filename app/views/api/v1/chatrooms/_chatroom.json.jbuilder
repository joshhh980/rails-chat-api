json.extract! chatroom, :id
if chatroom.messages.last 
    json.last_message do
        json.partial! "api/v1/messages/last_message", message: chatroom.messages.last
    end
end
json.other_user do
    json.partial! "api/v1/users/user", user: chatroom.other_user(current_user)
end