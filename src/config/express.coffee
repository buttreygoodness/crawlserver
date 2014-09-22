module.exports =
  "port": 8888,
  "cache": "Memory",
  "cache for": 3600,
  "transport": "Casper",
  "transport from": "http://0.0.0.0:3000",
  "transport filter": ["script"],
  "assets capture": [""],

  "log": (message) ->
    console.log "[#{Date.now()}]: #{message}"
