{Message} = require 'hubot'


# Hubot only started exporting Message in 2.11.0. Previous version do not export
# this class. In order to remain compatible with older versions, we can pull the
# Message class from TextMessage superclass.
if not Message
  Message = TextMessage.__super__.constructor


class LineImageMessage extends Message
  constructor: (@user, @robot, @message) ->
    super @user

  content: (callback) ->
    @robot.adapter.getContent @message.id, (content) ->
      callback content


class LineVideoMessage extends Message
  constructor: (@user, @robot, @message) ->
    super @user

  content: (callback) ->
    @robot.adapter.getContent @message.id, (content) ->
      callback content


class LineAudioMessage extends Message
  constructor: (@user, @robot, @message) ->
    super @user

  content: (callback) ->
    @robot.adapter.getContent @message.id, (content) ->
      callback content


class LineLocationMessage extends Message
  constructor: (@user, @message) ->
    @title = @message.title
    @address = @message.address
    @latitude = @message.latitude
    @longitude = @message.longitude
    super @user


class LineStickerMessage extends Message
  constructor: (@user, @message) ->
    @packageId = @message.packageId
    @stickerId = @message.stickerId
    super @user


class LineFollow extends Message
  constructor: (@user) ->
    super @user


class LineUnfollow extends Message
  constructor: (@user) ->
    super @user


class LineJoin extends Message
  constructor: (@user) ->
    super @user


class LineLeave extends Message
  constructor: (@user) ->
    super @user


class LinePostback extends Message
  constructor: (@user, @postback) ->
    @data = @postback.data
    super @user


class LineBeacon extends Message
  constructor: (@user, @beacon) ->
    @hwid = @beacon.hwid
    @type = @beacon.type
    super @user


module.exports = {
  LineImageMessage
  LineVideoMessage
  LineAudioMessage
  LineLocationMessage
  LineStickerMessage
  LineFollow
  LineUnfollow
  LineJoin
  LineLeave
  LinePostback
  LineBeacon
}
