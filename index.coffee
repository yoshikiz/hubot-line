LineAdapter = require './src/line'
{LineImageMessage, LineVideoMessage, LineAudioMessage, LineLocationMessage, LineStickerMessage, LineFollow, LineUnfollow, LineJoin, LineLeave, LinePostback, LineBeacon} = require './src/message'
{LineImageListener, LineVideoListener, LineAudioListener, LineLocationListener, LineStickerListener, LineFollowListener, LineUnfollowListener, LineJoinListener, LineLeaveListener, LinePostbackListener, LineBeaconListener} = require './src/listener'

module.exports = exports = {
  LineAdapter

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

  LineImageListener
  LineVideoListener
  LineAudioListener
  LineLocationListener
  LineStickerListener
  LineFollowListener
  LineUnfollowListener
  LineJoinListener
  LineLeaveListener
  LinePostbackListener
  LineBeaconListener
}

exports.use = (robot) ->
  new LineAdapter robot
