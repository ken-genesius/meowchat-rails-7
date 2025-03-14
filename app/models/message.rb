class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  after_create_commit { broadcast_append_to chatroom }
  before_create :confirm_member

  def confirm_member
    return unless chatroom.is_private

    is_member = Chatroommember.where(user_id: self.user.id, chatroom_id: self.chatroom.id).first
    throw :abort unless is_member
  end
end
