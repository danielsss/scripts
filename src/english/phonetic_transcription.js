const sources = require('./source.json');
const crypto  = require('crypto');
const got = require('./download');
const fs = require('fs');
const path = require('path');

const metadata = [];

const run = async function() {
  for (const entry of sources.log.entries) {
    if (!entry.request.url.endsWith('.mp3')) {
      continue;
    }
    const parts = entry.request.url.split('/');
    const encoded_full_name = parts[parts.length - 1];
    const download_url = entry.request.url;
    const body = {};
    const url = decodeURIComponent(entry.request.url);
    const arr = url.split('/');
    const name = arr[arr.length - 1];
    const decoded_name = name.split('.')[0];
    const hash = crypto.createHash('md5').update(decoded_name, 'utf-8').digest('hex');
    body.hash_name = hash;
    body.decoded_name = decoded_name;
    body.encoded_full_name = encoded_full_name;
    const n = body.decoded_name + '.mp3';
    body.path = 'medias/' + n;
    await got(download_url, n).then(() => {
      console.info(body);
      metadata.push(body);
    });
  }
  console.info(metadata);
  return null;
}

run().then(() => {
  console.info('then');
  const p = path.join(__dirname, './medias/metadata.json');
  fs.writeFileSync(p, JSON.stringify(metadata, null, 2));
  console.info('done !!!');
}).catch(err => {
  console.info(err);
})



