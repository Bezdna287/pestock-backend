const fs = require('fs');
const ExifReader = require('exifreader')
const moment = require('moment');

/* Reads file from "filePath" and returns base64 string representation*/
async function getB64(filePath){
  let data = fs.readFileSync('images/' + filePath, 'base64');
  const b64String = Buffer.from(data, 'binary').toString();
  return b64String;
}

/* Returns array with all file names contained in directory "path"*/
const readDirectory = (path) => fs.readdirSync(path);

/* Reads file from "filePath" and parses file metadata and
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