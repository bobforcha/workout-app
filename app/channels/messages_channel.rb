class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def checkin(data)
    room_id = "#{data['room_id']}"
    stream_from "messages_room_#{room_id}"
  end

  def checkout
    stop_all_streams
  end
end
