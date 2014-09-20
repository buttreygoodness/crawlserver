Crawlserver = require('crawlserver');
PORT = process.env.PORT || 8888;
WEBHOST = process.env.WEBHOST || "http://0.0.0.0:3000";

cs = new Crawlserver({
  "port": PORT,
  "transport from": WEBHOST
});

cs.listen(PORT);