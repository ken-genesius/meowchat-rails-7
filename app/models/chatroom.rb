class Chatroom < ApplicationRecord
  scope :public_rooms, -> { where(is_private: false) }
  after_create_commit { broadcast_if_public }
  has_many :messages

  def broadcast_if_public
    broadcast_append_to "chatrooms" unless self.is_private
  end
end
