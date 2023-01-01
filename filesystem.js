const fs = require('fs');
const path = require('path');

const getB64 = (fileName)=>{
    return fs.readFileSync('images/'+fileName,'base64',(err,data)=>{
        if(err){
            console.log(err)
            throw err;
        }

        const b64String = Buffer.from(data, 'binary').toString('base64');
        // console.log(b64String)
        return b64String.toString();
    });
}

const readDirectory =(dir)=>{

    let files = fs.readdirSync(dir) // gives all the files
    let promises = files.map(file => parseFile(path.join(dir, file))) // gives an array of promises for each file
    Promise.all(promises).then(console.log) 

}
function parseFile(filePath) {
    let content
    let output = new Promise((resolve, reject) => {
      fs.readFile(filePath, 'base64',function(err, data) {
      if (err) reject( err )

      content = data.toString().split(/(?:\r\n|\r|\n)/g).map(function(line) {
        return line.trim()
      }).filter(Boolean)

    // const b64String = Buffer.from(data, 'binary').toString('base64');

        
      resolve(console.log(content))
    })
  })
    return output
  }
module.exports = { getB64,readDirectory }