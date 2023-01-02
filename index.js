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

app.get(apiName+'/daigua', (req, res) => {
    
    let fileNames = fileSystem.readDirectory('./images');

    fileNames.forEach(async fileName=>{
        
        let exists = await db.countImagesByFileName(fileName);

        if(!exists){
            console.log('file '+fileName+' should be created')
            await db.insertImage(fileName);
        }
    })

    res.send('TEDICHOKEDAIWA')
})


app.listen(apiPort, () => {
    console.log(`Server running on port ${apiPort}`)
});