const queries = require('./database/queries')
const fileSystem = require('./filesystem')

async function findAllImages(req, res){
    let images = await queries.getImages(); 
    res.status(200).json(images);
}

async function findImageById(req,res){
    const id = parseInt(req.params.id);
    let image = await queries.getImageById(id);
    let imageB64 = await getImagesB64(image);
    res.status(200).json(imageB64);
}

async function findImagesByFileNames(req,res){
    const fileNames = req.query.fileName.split(',');
    let images = await queries.getImagesByFileNames(fileNames);
    let imageB64 = await getImagesB64(images);
    res.status(200).json(imageB64);
}

async function getImagesB64(bdImages){
    return await Promise.all(bdImages.map(async image=>{
        const collection = await queries.getCollectionById(image.id_collection);
        image.b64 = await fileSystem.getB64(collection.name+'/'+image.file_name);
        return image
    }));
}


module.exports = { findAllImages, findImageById,findImagesByFileNames }