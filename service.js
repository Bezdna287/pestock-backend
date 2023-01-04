const db = require('./database/queries')
const fileSystem = require('./filesystem')

async function findAllImages(req, res){
    let images = await db.getImages(); 
    res.status(200).json(images);
}

async function findImageById(req,res){

    
}




module.exports = {findAllImages }