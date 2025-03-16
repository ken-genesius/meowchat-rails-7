class Api::V1::ChatroomsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @chatrooms = Chatroom.public_rooms
    # @single_chatroom = Chatroom.find(params[:id])

    # @message = Message.new
    # @messages = @single_chatroom.messages.order(created_at: :asc)

    @users = User.all_except(current_user)

    render json: {
      chatrooms: @chatrooms,
      users: @users
    }
  end

  def create
    chatroom = Chatroom.create(name: params[:name])

    ActionCable.server.broadcast "chatrooms_channel",
    {
      type: "newChatroom",
      chatroom: chatroom
    }

    render json: {
      chatroom: chatroom
    }
  end

  def initiate_chatroom
    currentUser = User.find(params[:currentId])
    typeId = params[:typeId]
    typeName = params[:typeName]

    single_chatroom = nil
    targetName = nil

    if typeName == "user"
      targetUser = User.find(typeId)
      targetName = targetUser.username
      chatroomName = get_name(currentUser, targetUser)
      single_chatroom = Chatroom.where(name: chatroomName).first || Chatroom.create_private_room([ targetUser, currentUser ], chatroomName)
    elsif typeName == "chatroom"
      single_chatroom = Chatroom.find(typeId)
      targetName = single_chatroom.name
    end

    messages = single_chatroom.messages.order(created_at: :asc)

    messages_with_username = messages.map do |message|
      message.attributes.merge(username: message.user.username)
    end

    render json: {
      typeName: typeName,
      typeData: {
        id: single_chatroom.id,
        name: targetName,
        created_at: single_chatroom.created_at,
        updated_at: single_chatroom.updated_at
      },
      messages: messages_with_username
    }
  end

  private
    def get_name(user1, user2)
      users = [ user1, user2 ].sort
      "private_#{users[0].id}.#{users[1].id}"
    end
end
