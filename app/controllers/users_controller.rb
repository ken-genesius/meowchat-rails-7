class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @chatroom = Chatroom.new
    @chatrooms = Chatroom.public_rooms

    @chatroom_name = get_name(@user, current_user)
    @single_chatroom = Chatroom.where(name: @chatroom_name).first || Chatroom.create_private_room([ @user, current_user ], @chatroom_name)

    @message = Message.new
    @messages = @single_chatroom.messages.order(created_at: :asc)

    render "chatrooms/index"
  end

  def index
    @users = User.all()
    render json: @users.to_json
  end

  private
  def get_name(user1, user2)
    users = [ user1, user2 ].sort
    "private_#{users[0].id}.#{users[1].id}"
  end
end
