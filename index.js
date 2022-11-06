const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors')
const app = express()
const apiPort = 3000
const db = require('./database/queries')

app.use(bodyParser.urlencoded({ extended: true }))
app.use(cors())
app.use(bodyParser.json())



app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get('/images', db.getImages)

app.get('/images/:id', db.getImagesById)

app.get('/daigua', (req, res) => {
    res.send('TEDICHOKEDAIWA')
})


app.listen(apiPort, () => {
    console.log(`Server running on port ${apiPort}`)
});