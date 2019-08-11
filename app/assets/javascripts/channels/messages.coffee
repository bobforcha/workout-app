App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    roomId = $("#chat-box").data("room-id")
    @checkin(roomId)

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    posts = $(".message-row").length
    if posts == 10
      $(".message-row").first().remove()
    
    $("#chat-box").append(data)
    $("#message-field").val('')

  checkin(roomId) ->
    if roomId
      @perform 'checkin', room_id: roomId
    else
      @perform 'checkout'