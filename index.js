require('dotenv').config();
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const apiName = '/pestock'
const apiPort = process.env.PORT || 3000
const service = require('./service')

const origins = [
    process.env.ORIGINS || "http://localhost:4200",
]

app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(bodyParser.json())

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get(apiName+'/sync', service.synchronize)

app.get(apiName+'/images/all', service.findAllImages)

app.get(apiName+'/images/:id', service.findImageById)

app.get(apiName+'/images', service.findImagesByFileNames)

app.get(apiName+'/collections', service.getCollections)

app.get(apiName+'/collections/:idCollection', service.getCollectionById)

app.get(apiName+'/collection/:idCollection', service.getImagesByCollection)


app.listen(apiPort, () => {
    console.log(`Server running on port ${apiPort}`)
});