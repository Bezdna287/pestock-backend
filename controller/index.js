const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const apiName = '/pestock'
const apiPort = process.env.PORT || 3000
const service = require('../service')
const fileUpload = require('express-fileupload');
const moment = require('moment');

const origins = [
    process.env.ORIGIN_INNER ,
    process.env.ORIGIN_OUTER,
    "http://localhost:4200",
]

var corsOptions = {
    origin: origins,
    optionsSuccessStatus: 200 // some legacy browsers (IE11, various SmartTVs) choke on 204
  }

app.use(fileUpload())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors(corsOptions))
app.use(bodyParser.json())

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.post(apiName+'/sync', service.synchronize)

app.get(apiName+'/images/all', service.findAllImages)

app.get(apiName+'/image/:id', service.findImageById)

app.get(apiName+'/images', service.findImagesBy)

app.get(apiName+'/images/inactive', service.getInactiveImages)

app.post(apiName+'/collections', service.insertCollection)

app.get(apiName+'/collections', service.getCollections)

app.get(apiName+'/collections/:idCollection', service.getCollectionById)

app.get(apiName+'/collections/images/:idCollection', service.getImagesByCollection)

app.post(apiName+'/upload', service.upload)

app.post(apiName+'/update', service.update)

app.get(apiName+'/checkDir', service.checkNewDirectories)

app.delete(apiName+'/delete/:id', service.deleteImage)

app.listen(apiPort, () => {
    let time = '['+moment(Date.now()).format('DD/MM/yyyy - HH:mm:ss')+']'
    console.log(
       '\n'+ time+" %cTAMARISTA PSTOCK BACKEND",
        "color: blue; font-size: 55px; background-color: yellow;"
      );
    console.log(`\nServer running on port ${apiPort}`)
});