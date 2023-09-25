const queries = require('./database/queries')
const fileSystem = require('./filesystem')

async function upload(req,res){
    console.log('UPLOADING FILES')
    let rawFiles = Object.values(req['files'] ?? {})
    let body = req['body']
    let meta = JSON.parse(body['meta'])
    // console.log('\nmetadata: ')
    // console.log(meta)
    let shouldSync = meta.sync;
    
    let msg = 'processing '+rawFiles.length+' new files '+(shouldSync? 'and' : 'without')+' sync';
    console.log(msg)
    if(rawFiles.length > 0){
        let files = rawFiles.map(f=>{
            let i = rawFiles.indexOf(f)
            return {number: i, name:f.name, bytes:f.data, collection: meta[i] ?? 'dummyCollection'}
        })
        await fileSystem.saveFiles(files)
        
        collection_id = await queries.getCollectionIdByName(files[0].collection)
        if(collection_id == undefined){
            newCollection = await queries.insertCollection(files[0].collection)
        }

        res.status(200).json({message: msg, response:[], resized: false});
    }else{
        
        body={message: 'no files uploaded', inserted:0, resized: false}
        res.status(200).json(body)
    }
}

/* check if filesystem has collections not inserted in database*/
async function checkNewDirectories(req,res){
    let directories = fileSystem.readDirectory('./images');
        
    let inserted = []
    let processed = 0;
    try{
    directories.forEach(async d=>{
        id = await queries.getCollectionIdByName(d.name)
        if(id == undefined){ // collection does not exist in BD
            inserted.push(await queries.insertCollection(d.name))
        }
        processed++
        if(processed == directories.length){
            let msg = inserted ? inserted.length+' new collections inserted' : 'no new collections found'
            res.status(200).json({message: msg, response:inserted, shouldSync: inserted.length > 0});
        }
    });
    }catch(error){
        console.error(error)
        res.status(200).json({message: 'error checking new directories', response:error});
    }
}

async function synchronize(req, res) {
    let dir = req.query.dir;
    let fileNames = fileSystem.readDirectory('./images/'+dir).filter(f => f.isFile()).map(f => f.name);
    let numFiles = fileNames.length
    console.log('\nTriggered Filesystem-Database Syncronization:\n');

    console.log('\tparsing and resizing '+numFiles+' files: '+fileNames+'\n from directory \''+dir+'\':\n');
    
    let inserted = [];
    let resized = [];
    let notResized= [];
    let processed = 0;
    
        fileNames.forEach(async fileName=>{
            let exists = await queries.countImagesByFileName(fileName);
            if(exists == 0){
                console.log('\tfile '+dir+'/'+fileName+' is new, will be added to database')
                inserted.push(await queries.insertImage(dir+'/'+fileName));
            }
            if(await isItResized(dir,fileName)){
                resized.push(fileName)
                console.log(fileName+' is resized')
            }else{
                notResized.push(fileName)
                console.log(fileName+' is NOT resized')
            }
            
            processed++;

            if(processed == numFiles){
                let numInserted = inserted.length
                let shouldResize = resized.length != numFiles;
                let status = numInserted+' new images inserted'
                console.log('\n\t'+status)
                
                if(shouldResize || inserted.length > 0){
                    console.log('Resizing: ',notResized)
                    body={message: status, inserted:inserted, resized: notResized}
                    resizeResult = await fileSystem.resize(res,body,dir,fileNames);
                }else{
                    body={message: 'no files to sync', inserted:0, resized: []}
                    res.status(200).json(body)
                }
            }
        });
}

async function isItResized(dir,filename){
    return fileSystem.exists('./images/'+dir+'/resized/'+filename)
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

async function getImagesNoCollection(req,res){
    let images = await queries.getImagesNoCollection();
    let imagesb64 = await getImagesB64(images);
    res.status(200).json(imagesb64)
}

async function deleteImage(req,res){
    const id = parseInt(req.params.id);
    let del = await queries.deleteImage(id)
    res.status(200).json({"id":id, "message": 'deleted successfully', "im":del})
}

module.exports = {
    deleteImage,
    synchronize,
    findAllImages,
    findImageById,
    findImagesBy,
    getCollections,
    getCollectionById,
    getImagesByCollection,
    getImagesNoCollection,
    upload,
    checkNewDirectories
}