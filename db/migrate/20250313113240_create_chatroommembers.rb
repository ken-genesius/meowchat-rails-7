class CreateChatroommembers < ActiveRecord::Migration[7.2]
  def change
    create_table :chatroommembers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
