require('dotenv').config();
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const apiName = '/pestock'
const apiPort = process.env.PORT || 3000
const service = require('./service')
const fileUpload = require('express-fileupload');

const origins = [
    process.env.ORIGINS || "http://localhost:4200",
   "http://95.18.247.212:4200",
   "http://192.168.1.56:4200"
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

app.get(apiName+'/sync', service.synchronize)

app.get(apiName+'/images/all', service.findAllImages)

app.get(apiName+'/images/:id', service.findImageById)

app.get(apiName+'/images', service.findImagesBy)

app.get(apiName+'/collections', service.getCollections)

app.get(apiName+'/collections/:idCollection', service.getCollectionById)

app.get(apiName+'/collection/:idCollection', service.getImagesByCollection)

app.post(apiName+'/upload', service.upload)

app.listen(apiPort, () => {
    console.log(`Server running on port ${apiPort}`)
});