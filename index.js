const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const apiName = '/pestock'
const apiPort = 3000
const db = require('./database/queries')
const fileSystem = require('./filesystem')

const origins = [
    "http://localhost:4200",
]

app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(bodyParser.json())

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get(apiName+'/images', db.getImages)

app.get(apiName+'/images/:id', db.getImageById)

app.get(apiName+'/image', db.getImageByFileName)

app.get(apiName+'/collections', db.getCollections)

app.get(apiName+'/collections/:idCollection', db.getCollectionById)

app.get(apiName+'/collection/:idCollection', db.getImagesByCollection)

app.get(apiName+'/sync', (req, res) => {
    let dir = req.query.dir;
    let fileNames = fileSystem.readDirectory('./images/'+dir);
    let numFiles = fileNames.length
    console.log('parsing '+numFiles+' files: '+fileNames+' from dir '+dir);
    
    let inserted = [];
    let processed = 0;
    
    fileNames.forEach(async fileName=>{
        let exists = await db.countImagesByFileName(fileName);

        if(exists == 0){
            console.log('file '+dir+'/'+fileName+' should be inserted')
            inserted.push(await db.insertImage(dir+'/'+fileName));
        }
        processed++;
        if(processed == numFiles){
            let status = 'Inserted '+inserted.length+' new images'

            console.log(status)
            console.log(inserted)
            
            res.status(200).json({message: status, response:inserted})
        }
    });
    
})


app.listen(apiPort, () => {
    console.log(`Server running on port ${apiPort}`)
});