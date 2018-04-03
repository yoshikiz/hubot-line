{Listener} = require 'hubot'
{LineImageMessage, LineVideoMessage, LineAudioMessage, LineLocationMessage, LineStickerMessage, LineFollow, LineUnfollow, LineJoin, LineLeave, LinePostback, LineBeacon} = require './message'


class LineImageListener extends Listener
  # LineImageListeners receive LineImageMessages from the Line adapter and decide if they want to act on it.
  #
  # robot    - A Robot instance.
  # matcher  - A Function that determines if this listener should trigger the callback. The matcher takes a LineImageMessage.
  # callback - A Function that is triggered if the incoming message matches.
  #
  # To use this listener in your own script, you can say
  #
  #     robot.listeners.push new LineImageListener(robot, matcher, callback)
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineImageMessage
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineVideoListener extends Listener
  # LineVideoListeners receive LineVideoMessages from the Line adapter and decide if they want to act on it.
  #
  # robot    - A Robot instance.
  # matcher  - A Function that determines if this listener should trigger the callback. The matcher takes a LineVideoMessage.
  # callback - A Function that is triggered if the incoming message matches.
  #
  # To use this listener in your own script, you can say
  #
  #     robot.listeners.push new LineVideoListener(robot, matcher, callback)
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineVideoMessage
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineAudioListener extends Listener
  # LineAudioListeners receive LineAudioMessages from the Line adapter and decide if they want to act on it.
  #
  # robot    - A Robot instance.
  # matcher  - A Function that determines if this listener should trigger the callback. The matcher takes a LineAudioMessage.
  # callback - A Function that is triggered if the incoming message matches.
  #
  # To use this listener in your own script, you can say
  #
  #     robot.listeners.push new LineAudioListener(robot, matcher, callback)
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineAudioMessage
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineLocationListener extends Listener
  # LineLocationListeners receive LineLocationMessages from the Line adapter and decide if they want to act on it.
  #
  # robot    - A Robot instance.
  # matcher  - A Function that determines if this listener should trigger the callback. The matcher takes a LineLocationMessage.
  # callback - A Function that is triggered if the incoming message matches.
  #
  # To use this listener in your own script, you can say
  #
  #     robot.listeners.push new LineLocationListener(robot, matcher, callback)
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineLocationMessage
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineStickerListener extends Listener
  # LineStickerListeners receive LineStickerMessages from the Line adapter and decide if they want to act on it.
  #
  # robot    - A Robot instance.
  # matcher  - A Function that determines if this listener should trigger the callback. The matcher takes a LineStickerMessage.
  # callback - A Function that is triggered if the incoming message matches.
  #
  # To use this listener in your own script, you can say
  #
  #     robot.listeners.push new LineStickerListener(robot, matcher, callback)
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineStickerMessage
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineFollowListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineFollow
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineUnfollowListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineUnfollow
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineJoinListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineJoin
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineLeaveListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineLeave
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LinePostbackListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LinePostback
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


class LineBeaconListener extends Listener
  constructor: (@robot, @matcher, @callback) ->

  call: (message, middleware, cb) ->
    if message instanceof LineBeacon
      super message, middleware, cb
    else
      if cb?
        process.nextTick -> cb false
      false


module.exports = {
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
