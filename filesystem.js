const fs = require('fs');
const ExifReader = require('exifreader')
const moment = require('moment');
const {spawn} = require('child_process');

/* Reads file from "filePath" and returns base64 string representation*/
async function getB64(filePath){
  let data = [];
  let path = 'images/' + filePath;
  
  if(fs.existsSync(path)){
    data = fs.readFileSync(path, 'base64');
  }
    
  const b64String = Buffer.from(data, 'binary').toString();
  return b64String;
}

/* Returns array with all file names contained in directory "path"*/
const readDirectory = (path) => fs.readdirSync(path, { withFileTypes: true });

/* Reads file from "filePath" and parses file metadata and
   returns image data structure following DB object model */
async function parseFile(filePath) {
  
  let dataBuffer = fs.readFileSync('./images/'+filePath);
  const tags = ExifReader.load(Buffer.from(dataBuffer, 'binary'), {
    expanded: false,
    includeUnknown: false
  });
  
  let [collection,fileName] = filePath.split('/');
   
  // console.log(tags);
  // console.log('---------------------------------------------------------------------')

  // TODO: implement types to avoid manual object parsing
  return { 
    title: tags.ImageDescription?.description ? tags.ImageDescription?.description : 'Dummy title (it was empty)',
    keywords: ' '+(tags.subject?.description ? tags.subject?.description : 'key00, key01, key02, key03, key04 (it was empty)'),
    id_collection: collection,
    height: tags['Image Height']?.value,
    width: tags['Image Width']?.value,
    date_publish: moment(Date.now()).format('yyyy/MM/DD'),
    download: 0,
    file_name: fileName
    };
}

async function resize(res,body,dir,fileNames){
  
  // const python = spawn('python', ['resize.py', dir, fileNames]);
  const python = spawn('python3', ['resize.py', dir, fileNames]);
  
  console.log('\n\nStarting resize...\t')

  python.stdout.on('data', function (data) {
    console.log('\n\n\t' + data.toString());
  });

  python.on('close', async (code) => {
    console.log(`\tResize exited with code ${code}\n`);
    if(code === 0){
      body.resized = true;
      res.status(200).json(body)
    }   
  });

  python.stderr.on('data', (data) => {
    console.log(`\tstderr: ${data}\n`);
    res.status(400).json({message: 'error resizing', response:[], resized: false})
  });
}


async function saveFiles(files){
  await files.forEach(async f=>{
    let dir = './images/'+f.collection
    let filePath = dir+'/'+f.name;
    
    if(!fs.existsSync(dir)){
      console.error('\npath '+dir+' doesnt exist. creating...')
      await mkdir(dir)
    }
    
    console.log('\nwriting '+filePath)

    fs.writeFileSync(filePath,f.bytes,{flag:'w'})
    
    console.log('\nadding to '+dir+': ')
    console.log(readDirectory(dir).filter(f => f.isFile()).map(f => f.name))    
  })

  
}

async function mkdir(dir){
  fs.mkdir(dir, async (err) => {
    if (err) {
        return console.error(err);
    }
    console.log('directory '+dir+' created successfully');
  });
}

module.exports = { getB64, readDirectory,parseFile,resize, saveFiles }