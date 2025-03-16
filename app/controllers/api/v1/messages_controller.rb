class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    chatroom_id = params[:chatroom_id]
    user_id = params[:user_id]
    user = User.find(user_id)
    chatroom = Chatroom.find(chatroom_id)
    message = user.messages.create(body: params[:body], chatroom_id: chatroom_id)

    message_with_username = message.attributes.merge(username: user.username)

    ActionCable.server.broadcast "messages_channel_#{chatroom_id}",
    {
      type: "newMessages",
      message: message_with_username,
      chatroom: chatroom
    }

    render json: {
      message: message,
      chatroom: chatroom
    }
  end

  private
  def msg_params
    params.require(:message).permit(:body)
  end
end
