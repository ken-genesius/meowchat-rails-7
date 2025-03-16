class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:id]
      chatroom = Chatroom.find(params[:id])
      stream_from "messages_channel_#{chatroom.id}" if chatroom
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
