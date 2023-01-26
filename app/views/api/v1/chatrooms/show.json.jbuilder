json.partial! "api/v1/chatrooms/chatroom", chatroom: @chatroom
json.messages @chatroom.messages, partial: "api/v1/messages/message", as: :message