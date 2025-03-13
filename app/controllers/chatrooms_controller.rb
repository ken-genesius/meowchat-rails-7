class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.public_rooms

    @users = User.all_except(current_user)
  end

  def show
    @chatroom = Chatroom.new
    @chatrooms = Chatroom.public_rooms
    @single_chatroom = Chatroom.find(params[:id])

    @message = Message.new
    @messages = @single_chatroom.messages.order(created_at: :asc)

    @users = User.all_except(current_user)
    render "index"
  end

  def create
    @chatroom = Chatroom.create(name: params[:chatroom][:name])
  end
end
