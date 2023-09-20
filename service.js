const queries = require('./database/queries')
const fileSystem = require('./filesystem')

async function upload(req,res){
    let files = Object.values(req['files'] ?? {})
    console.log(files)

    //create file from bytes (file.data)
    // Object.values(files).forEach(f=>console.log(f))


    //save file to disk
    //return confirmation about inserts and resize

    res.status(200).json('iyo perfe');
}


async function synchronize(req, res) {
    let dir = req.query.dir;
    let fileNames = fileSystem.readDirectory('./images/'+dir).filter(f => f.isFile()).map(f => f.name);
    let numFiles = fileNames.length
    console.log('\nTriggered Filesystem-Database Syncronization:\n');

    console.log('\tparsing and resizing '+numFiles+' files: '+fileNames+'\n from directory \''+dir+'\':\n');
    
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
            
            body={message: status, inserted:inserted, resized: false}
            resizeResult = await fileSystem.resize(res,body,dir,fileNames);
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
    const keywords = req.query.keywords.split(',').map(each=>'% '+each.trim()+'%');
    console.log('\nparsed keywords:')
    console.table(keywords)
    let images = await queries.getImagesByKeywords(keywords);
    let imagesb64 = await getImagesB64(images);
    console.log('returning '+imagesb64.length + ' images with requested keywords')
    res.status(200).json(imagesb64);
}


/* Reads collection names and fileNames from BD and
    returns parsed images with base64 string representation*/
async function getImagesB64(bdImages, resized = true){ 
    return await Promise.all(bdImages.map(async image=>{
        const collectionName = await queries.getCollectionNameById(image.id_collection);

        image.b64 = await fileSystem.getB64(collectionName+'/'+(resized ? 'resized/' : '')+image.file_name); 
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

async function getImagesByCollection(req,res){
    const idCollection = parseInt(req.params.idCollection);
    let images = await queries.getImagesByCollection(idCollection);
    let imagesb64 = await getImagesB64(images);
    res.status(200).json(imagesb64);
}


module.exports = { synchronize, findAllImages, findImageById,findImagesBy, getCollections, getCollectionById, getImagesByCollection, upload }