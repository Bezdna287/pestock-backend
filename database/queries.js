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

async function countImagesByFileName(fileName) {
  const fileNames = fileName.split(',').map(each=>'\''+each+'\'').join(',')
  
  let result = await pool.query('SELECT count(1) FROM images WHERE "file_name" in ('+fileNames+')')

  return result.rows[0].count
}

async function insertImage(fileName){
  const metadata = await getMetadata(fileName);

  let result =  await pool.query('INSERT into images (title, keywords, id_collection, height, width, date_publish, download, file_name) VALUES ('+metadata+') RETURNING *');
  
  console.log(result)
  
  return result.rows;
}

async function getMetadata(fileName){
  // let title = 
  return {}
}

const handleCount = (error, results) => {
  if (error) {
    throw error
  }
  count = results.rows[0].count
  
  if(count == 0){
    //image doesnt exist, should insert
    // let metadata = getMetadata()
    
    // pool.query('INSERT into images (id, title, keywords, id_collection, height, width, date_publish, download, file_name) VALUES', [metadata], (error, result)=>{

    // })
  }

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