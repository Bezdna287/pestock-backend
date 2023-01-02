const fileSystem = require('../filesystem')
const iptc = require('node-iptc')
const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'Cashimba01',
  port: 4000,
})

const getImages = (request, response) => {
  pool.query('SELECT * FROM images ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getImageById = (request, response) => {
  const id = parseInt(request.params.id)

  pool.query('SELECT * FROM images WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getImageByFileName = (request, response) => {
  const fileNames = request.query.file_name.split(',').map(each=>'\''+each+'\'').join(',')
  // console.log(fileNames)
  pool.query('SELECT * FROM images WHERE "file_name" in ('+fileNames+')', (error, results) => {
    if (error) {
      throw error
    }
    let image = getImagesB64(results.rows)
    
    response.status(200).json(image)
  })
}
// THIS SHOULD ALSO COUNT BY COLLECTION: same filename SHOULD be allowed in different collections?
async function countImagesByFileName(fileName) {
  const fileNames = fileName.split(',').map(each=>'\''+each+'\'').join(',')
  
  let result = await pool.query('SELECT count(1) FROM images WHERE "file_name" in ('+fileNames+')')

  return result.rows[0].count
}

async function insertImage(filePath){
  const parsedImage = await fileSystem.parseFile(filePath)
  
  parsedImage.id_collection = await getIdCollectionByName(parsedImage.id_collection)

  // console.log(parsedImage)
  
  let result =  await pool.query('INSERT into images (id,title, keywords, id_collection, height, width, date_publish, download, file_name) VALUES (nextval(\'images_id\'),$1,$2,$3,$4,$5,$6,$7,$8) RETURNING *',Object.values(parsedImage));
  
  console.log('inserted: ')
  console.log(result.rows)
  
  // return result.rows;
}


const getImagesByCollection = (request, response) => {
  const idCollection = parseInt(request.params.idCollection)

  pool.query('SELECT * FROM images WHERE id_collection = $1', [idCollection], (error, results) => {
    if (error) {
      console.log(error)
      throw error
    }
    // instead of returning raw image array from BD, the b64 string gets added to each image
    let images = getImagesB64(results.rows)
    
    response.status(200).json(images)
  })
}

const getCollections = (request, response) => {
  pool.query('SELECT * FROM collections ORDER BY id ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

const getCollectionById = (request, response) => {
  const idCollection = parseInt(request.params.idCollection)

  pool.query('SELECT * FROM collections WHERE id = $1', [idCollection], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

async function getIdCollectionByName(name){
  
  let collection = await pool.query('SELECT * FROM collections WHERE name like $1', [name]);
  return collection.rows[0].id;
}

function getImagesB64(bdImages){
  let images = [];
  bdImages.forEach(image=>{
      let b64str = fileSystem.getB64(image.file_name);
      // attribute "b64" of the object "image" setted to the b64 string
      image.b64 = b64str;
      images.push(image);
    })
  return images
}

module.exports = {
  insertImage,
  getImages,
  getImageById,
  getImageByFileName,
  countImagesByFileName,
  getCollections,
  getCollectionById,
  getImagesByCollection
}