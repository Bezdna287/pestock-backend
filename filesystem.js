const fs = require('fs');
const path = require('path');
const iptc = require('node-iptc')
const ExifReader = require('exifreader')
const moment = require('moment');

/* read file from "filePath" and returns base64 string representation*/
const getB64 = (filePath) => {
  return fs.readFileSync('images/' + filePath, 'base64', (err, data) => {
    if (err) {
      console.log(err)
      throw err;
    }
    const b64String = Buffer.from(data, 'binary').toString('base64');
    return b64String.toString();
  });
}

/* returns array with all file names contained in directory "path"*/
const readDirectory = (path) => fs.readdirSync(path);


/* reads file from "filePath" and parses file metadata.
   returns image data structure following DB object model */
async function parseFile(filePath) {
  
  let dataBuffer = fs.readFileSync('./images/'+filePath);
  const tags = ExifReader.load(Buffer.from(dataBuffer, 'binary'), {
    expanded: false,
    includeUnknown: false
  });
  
  let collection = filePath.split('/')[0];
  let fileName = filePath.split('/')[1];
   
  // console.log(tags);
  // console.log('---------------------------------------------------------------------')

  // TODO: implement types to avoid manual object parsing
  return { 
    title: tags.ImageDescription?.description ? tags.ImageDescription?.description : 'Dummy title (it was empty)',
    keywords: tags.subject?.description ? tags.subject?.description : 'key00, key01, key02, key03, key04 (it was empty)',
    id_collection: collection,
    height: tags['Image Height']?.value,
    width: tags['Image Width']?.value,
    date_publish: moment(Date.now()).format('DD/MM/yyyy'),
    download: 0,
    file_name: fileName
    };

}
module.exports = { getB64, readDirectory,parseFile }