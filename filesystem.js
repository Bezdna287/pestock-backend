const fs = require('fs');
const path = require('path');
const iptc = require('node-iptc')
const ExifReader = require('exifreader')

const getB64 = (fileName) => {
  return fs.readFileSync('images/' + fileName, 'base64', (err, data) => {
    if (err) {
      console.log(err)
      throw err;
    }
    const b64String = Buffer.from(data, 'binary').toString('base64');
    return b64String.toString();
  });
}

const readDirectory = (dir) => {

  let files = fs.readdirSync(dir)
  // console.log(files)

  let promises = files.map(file => parseFile(path.join(dir, file))) // gives an array of promises for each file
  Promise.all(promises).then()

  return files;

}
function parseFile(filePath) {
  let content
  let output = new Promise((resolve, reject) => {
    fs.readFile(filePath, function (err, data) {
      if (err) reject(err)

      content = data.toString().split(/(?:\r\n|\r|\n)/g).map(function (line) {
        return line.trim()
      }).filter(Boolean)

      const tags = ExifReader.load(Buffer.from(data, 'binary'), {
        expanded: false,
        includeUnknown: false
      });
      console.log('---------')
      console.log('path: '+filePath)
      console.log('keywords: '+tags.subject?.description)
      console.log('title: '+tags.ImageDescription?.description)
      // console.log(tags)
      
      // resolve()
    })
  })
  return output
}
module.exports = { getB64, readDirectory }