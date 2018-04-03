# hubot-line

This is a [Hubot](https://hubot.github.com/) adapter to use with [LINE](http://line.me/).  
This adapter is using [LINE Messaging API](https://developers.line.me/en/services/messaging-api/).  

## Installation
Install this repository as a dependency in your hubot.
```
$ npm install github:yoshikichung/hubot-line --save
```

## Usage
Define the following environment variables to use this adapter.

```sh
$ export HUBOT_LINE_CHANNEL_ID="your_channel_id"
$ export HUBOT_LINE_CHANNEL_SECRET="your_channel_secret"
$ export HUBOT_LINE_CHANNEL_TOKEN="your_channel_access_token"
$ export HUBOT_LINE_WEBHOOK_PATH="/path/to/callback"
```
Run hubot with this adapter.
```
$ bin/hubot -a line
```

## License

The MIT License. See `LICENSE` for details.
