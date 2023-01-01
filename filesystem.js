const fs = require('fs');
// import fs from 'fs';

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

module.exports = { getB64 }