const queries = require('./database/queries')
const fileSystem = require('./filesystem')

async function synchronize(req, res) {
    let dir = req.query.dir;
    let fileNames = fileSystem.readDirectory('./images/'+dir);
    let numFiles = fileNames.length
    console.log('\nTriggered Filesystem-Database Syncronization:\n');

    console.log('\tparsing '+numFiles+' files: '+fileNames+' from folder \''+dir+'\':\n');
    
    let inserted = [];
    let processed = 0;
    
    fileNames.forEach(async fileName=>{
        let exists = await queries.countImagesByFileName(fileName);

        if(exists == 0){
            console.log('\tfile '+dir+'/'+fileName+' is new, will be added to database')
            inserted.push(await queries.insertImage(dir+'/'+fileName));
        }
        processed++;
        if(processed == numFiles){
            let status = inserted.length+' new images inserted'

            console.log('\n\t'+status)
            // console.log(inserted)

            res.status(200).json({message: status, response:inserted})
        }
    });
    
}



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

async function findImagesBy(req,res){
    if(req.query.fileName){
        await findImagesByFileNames(req,res)
    }else if(req.query.keywords){
        await findImagesByKeywords(req,res)
    }
}

/* returns images from comma separated file names from param "fileName" */
async function findImagesByFileNames(req,res){
    const fileNames = req.query.fileName.split(',');
    let images = await queries.getImagesByFileNames(fileNames);
    let imageB64 = await getImagesB64(images);
    res.status(200).json(imageB64);
}

/* returns images from comma separated keywords from param "keywords" */
async function findImagesByKeywords(req,res){
    const keywords = req.query.keywords.split(',').map(each=>'%'+each+'%');
    console.log(keywords)
    let images = await queries.getImagesByKeywords(keywords);
    //let imagesb64 = await getImagesB64(images);
    console.log(images.length + ' images with selected keywords')
    res.status(200).json(images);
}


/* Reads collection names and fileNames from BD and
    returns parsed images with base64 string representation*/
async function getImagesB64(bdImages){ // maybe extra input arg to get /resized or /fullres ? 
    return await Promise.all(bdImages.map(async image=>{
        const collectionName = await queries.getCollectionNameById(image.id_collection);

        //maybe even just downscale only the requested images? sync is one-time but maybe the script every iteration makes everything too slow
        image.b64 = await fileSystem.getB64(collectionName+'/'+image.file_name); // this path should be edited to get /resized images instead
        return image
    }));
}

async function getCollections(req,res){
    let collections = await queries.getCollections();
    res.status(200).json(collections)
}

async function getCollectionById(req,res){
    const idCollection = parseInt(req.params.idCollection);
    let collection = await queries.getCollectionById(idCollection);
    res.status(200).json(collection);
}

//TODO: BAS64 STRING TOO HEAVY. LOWER RESOLUTION IMAGES WILL BE BETTER TO TRANSFER
async function getImagesByCollection(req,res){
    const idCollection = parseInt(req.params.idCollection);
    let images = await queries.getImagesByCollection(idCollection);
    let imagesb64 = await getImagesB64(images);
    res.status(200).json(imagesb64);
}


module.exports = { synchronize, findAllImages, findImageById,findImagesBy, getCollections, getCollectionById, getImagesByCollection }