class Chatroom < ApplicationRecord
  scope :public_rooms, -> { where(is_private: false) }
  after_create_commit { broadcast_if_public }
  has_many :messages
  has_many :chatroommembers, dependent: :destroy

  def broadcast_if_public
    broadcast_append_to "chatrooms" unless self.is_private
  end

  def self.create_private_room(users, room_name)
    single_room = Chatroom.create(name: room_name, is_private: true)
    users.each do |user|
      Chatroommember.create(user_id: user.id, chatroom_id: single_room.id)
    end
    single_room
  end
end
