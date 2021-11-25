const fs = require('fs');
const path = require('path');
const https = require('https');


module.exports = function(url, decoded_name) {
  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      const onError = function(err) {
        console.error(err);
        return reject(err);
      }
      console.info('-  %s', decoded_name);
      const destination = path.join(__dirname, './medias/', decoded_name);
      if (!fs.existsSync(destination)) {
        res.pipe(fs.createWriteStream(destination));  
      } else {
        resolve();
      }
      res.on('error', onError);
      res.on('end', resolve);
    });
  });
}