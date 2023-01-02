const fs = require('fs');
const path = require('path');
const iptc = require('node-iptc')
const ExifReader = require('exifreader')
const moment = require('moment');

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
  return files;

}

// const parseFiles = (files)=>{
//   let promises = files.map(file => parseFile(path.join(dir, file))) // gives an array of promises for each file
//   Promise.all(promises).then()
// }

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