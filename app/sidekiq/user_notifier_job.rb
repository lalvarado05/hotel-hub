class UserNotifierJob
  include Sidekiq::Job

  def perform(user_id, room_id)
    # Do something
    @user = User.find(user_id)
    @room = Room.find(room_id)
    RoomMailer.created_room(@room, @user).deliver_now
  end
end
