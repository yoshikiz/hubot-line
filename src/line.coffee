{Robot, Adapter, TextMessage} = require 'hubot'
{EventEmitter} = require 'events'
{LineImageMessage, LineVideoMessage, LineAudioMessage, LineLocationMessage, LineStickerMessage, LineFollow, LineUnfollow, LineJoin, LineLeave, LinePostback, LineBeacon} = require './message'
crypto = require 'crypto'


class LineAdapter extends Adapter
    
  send: (envelope, strings...) ->
    @robot.logger.debug "LINE send <#{JSON.stringify(strings)}> to <#{envelope.user.id}>"
    messages = []
    for string, i in strings when i < 5
      if typeof(string) is "string"
        message =
          type: "text"
          text: "#{string}"
        messages.push message
      else
        messages.push string
    @pushMessage envelope.user.id, messages

  reply: (envelope, strings...) ->
    @robot.logger.debug "LINE reply <#{JSON.stringify(strings)}> to <#{envelope.user.token}>"
    messages = []
    for string, i in strings when i < 5
      if typeof(string) is "string"
        message =
          type: "text"
          text: "#{string}"
        messages.push message
      else
        messages.push string
    @replyMessage envelope.user.token, messages

  pushMessage: (to, messages) ->
    url = "https://api.line.me/v2/bot/message/push"
    data =
      to: to
      messages: messages
    @postRequest url, @headers1, data

  replyMessage: (to, messages) ->
    url = "https://api.line.me/v2/bot/message/reply"
    data =
      replyToken: to
      messages: messages
    @postRequest url, @headers1, data

  getContent: (id, callback) ->
    url = "https://api.line.me/v2/bot/message/#{id}/content"
    @robot.http(url).headers(@headers2).encoding('binary')
      .get() (err, res, body) ->
        callback body, err, res

  getProfile: (id, callback) ->
    url = "https://api.line.me/v2/bot/profile/#{id}"
    query = ""
    @getRequest url, @headers2, query, (res) ->
      callback(res)

  leaveGroup: (id) ->
    url = "https://api.line.me/v2/bot/group/#{id}/leave"
    data = ""
    @postRequest url, @headers2, data

  leaveRoom: (id) ->
    url = "https://api.line.me/v2/bot/room/#{id}/leave"
    data = ""
    @postRequest url, @headers2, data

  postRequest: (url, headers, data) ->
    logger = @robot.logger
    @robot.http(url).headers(headers)
      .post(JSON.stringify(data)) (err, res, body) ->
        if err or res.statusCode isnt 200
          logger.error "LINE request [#{res.statusCode}] #{err} - #{body}"
        logger.debug "LINE request [#{res.statusCode}] - #{body}"

  getRequest: (url, headers, query, callback) ->
    logger = @robot.logger
    @robot.http(url).headers(headers).query(query)
      .get() (err, res, body) ->
        if err or res.statusCode isnt 200
          logger.error "LINE request [#{res.statusCode}] #{err} - #{body}"
        logger.debug "LINE request [#{res.statusCode}] - #{body}"
        callback(JSON.parse(body))


  run: ->
    self = @
    @robot.logger.debug 'LINE run'

    @channelId = process.env.HUBOT_LINE_CHANNEL_ID
    @channelSecret = process.env.HUBOT_LINE_CHANNEL_SECRET
    @channelToken = process.env.HUBOT_LINE_CHANNEL_TOKEN
    @webhookPath = process.env.HUBOT_LINE_WEBHOOK_PATH

    @headers1 =
      "Content-Type": "application/json"
      "Authorization": "Bearer #{@channelToken}"
    @headers2 =
      "Authorization": "Bearer #{@channelToken}"

    self.on 'message', (token, source, message) ->
      switch source.type
        when 'user'
          from = source.userId
        when 'group'
          from = source.groupId
        when 'zoom'
          from = source.zoomId
      user = @robot.brain.userForId from
      # Store reply token in robot.brain.user
      user.token = token
      text = message.text
      # Add robot name in front of the message text
      regex = new RegExp("^#{@robot.name}", "i")
      if !regex.test(text) #and source.type is 'user'
        text = "#{@robot.name} #{text}"

      switch message.type
        when 'text'
          @robot.logger.debug "LINE text message <#{text}> from <#{from}>"
          self.receive new TextMessage user, text, message.id
        when 'image'
          @robot.logger.debug "LINE image message from <#{from}>"
          self.receive new LineImageMessage user, @robot, message
        when 'video'
          @robot.logger.debug "LINE video message from <#{from}>"
          self.receive new LineVideoMessage user, @robot, message
        when 'audio'
          @robot.logger.debug "LINE audio message from <#{from}>"
          self.receive new LineAudioMessage user, @robot, message
        when 'location'
          @robot.logger.debug "LINE location message from <#{from}>"
          self.receive new LineLocationMessage user, message
        when 'sticker'
          @robot.logger.debug "LINE sticker message from <#{from}>"
          self.receive new LineStickerMessage user, message
        else
          @robot.logger.error "LINE unknown message from <#{from}>"

    self.on 'follow', (token, source) ->
      from = source.userId
      user = @robot.brain.userForId from
      user.token = token
      @robot.logger.debug "LINE follow from <#{from}>"
      self.receive new LineFollow user

    self.on 'unfollow', (source) ->
      from = source.userId
      user = @robot.brain.userForId from
      @robot.logger.debug "LINE unfollow from <#{from}>"
      self.receive new LineUnfollow user

    self.on 'join', (token, source) ->
      from = source.groupId
      user = @robot.brain.userForId from
      user.token = token
      @robot.logger.debug "LINE join from <#{from}>"
      self.receive new LineJoin user

    self.on 'leave', (source) ->
      from = source.groupId
      user = @robot.brain.userForId from
      @robot.logger.debug "LINE leave from <#{from}>"
      self.receive new LineLeave user

    self.on 'postback', (token, source, postback) ->
      switch source.type
        when 'user'
          from = source.userId
        when 'group'
          from = source.groupId
        when 'zoom'
          from = source.zoomId
      user = @robot.brain.userForId from
      user.token = token
      @robot.logger.debug "LINE postback <#{postback.data}> from <#{from}>"
      self.receive new LinePostback user, postback

    self.on 'beacon', (token, source, beacon) ->
      switch source.type
        when 'user'
          from = source.userId
        when 'group'
          from = source.groupId
        when 'zoom'
          from = source.zoomId
      user = @robot.brain.userForId from
      user.token = token
      @robot.logger.debug "LINE beacon <#{beacon.hwid}> from <#{from}>"
      self.receive new LineBeacon user, beacon
   
    @listen()
    @emit 'connected'


  listen: ->
    @robot.router.post @webhookPath, @validate, (req, res) =>
      @robot.logger.debug "LINE listen #{JSON.stringify(req.body.events)}"
      for event in req.body.events
        switch event.type
          when 'message'
            @emit 'message', event.replyToken, event.source, event.message
          when 'follow'
            @emit 'follow', event.replyToken, event.source
          when 'unfollow'
            @emit 'unfollow', event.source
          when 'join'
            @emit 'join', event.replyToken, event.source
          when 'leave'
            @emit 'leave', event.source
          when 'postback'
            @emit 'postback', event.replyToken, event.source, event.postback
          when 'beacon'
            @emit 'beacon', event.replyToken, event.source, event.beacon
      res.send 'ok'

      
  validate: (req, res, next) ->
    channelSecret = process.env.HUBOT_LINE_CHANNEL_SECRET
    channelSignature = req.get 'x-line-signature'
    hash = crypto.createHmac('sha256', channelSecret)
                 .update(JSON.stringify(req.body), 'utf8')
                 .digest('base64')
    if hash is channelSignature
      next()
    else
      @robot.logger.debug "LINE Signature invalid."
      res.status(470).end()


module.exports = LineAdapter
