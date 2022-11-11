json.extract! chatroom, :id
json.last_message do
    json.partial! "api/v1/messages/last_message", message: chatroom.messages.last
end
json.other_user do
    json.partial! "api/v1/users/user", user: chatroom.other_user(current_user)
end