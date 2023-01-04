const fileSystem = require('../filesystem')

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'Cashimba01',
  port: 4000,
})


async function getImages(){
  let result = await pool.query('SELECT * FROM images ORDER BY id ASC').catch(err=>console.log(err));
  return result.rows;
}

async function getImageById(id){
  let result =  await pool.query('SELECT * FROM images WHERE id = $1', [id]).catch(err=>console.log(err));
  return result.rows;
}

async function getImagesByFileNames(fileNames){
  let result = await pool.query('SELECT * FROM images WHERE "file_name" = ANY($1)',[fileNames]).catch(err=>console.log(err));
  return result.rows;
}


// THIS SHOULD ALSO COUNT BY COLLECTION: same filename SHOULD be allowed in different collections?
async function countImagesByFileName(fileName) {
  const fileNames = fileName.split(',').map(each=>'\''+each+'\'').join(',')
  
  let result = await pool.query('SELECT count(1) FROM images WHERE "file_name" in ('+fileNames+')')

  return result.rows[0].count
}

async function insertImage(filePath){
  const parsedImage = await fileSystem.parseFile(filePath)
  
  parsedImage.id_collection = await getCollectionByName(parsedImage.id_collection).id

  // console.log(parsedImage)
  
  let result =  await pool.query('INSERT into images (id,title, keywords, id_collection, height, width, date_publish, download, file_name) VALUES (nextval(\'images_id\'),$1,$2,$3,$4,$5,$6,$7,$8) RETURNING *',Object.values(parsedImage));
    
  return result.rows[0];
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

async function getCollectionByName(name){
  let collection = await pool.query('SELECT * FROM collections WHERE name like $1', [name]);
  return collection.rows[0];
}

async function getCollectionById(id){
  let collection = await pool.query('SELECT * FROM collections WHERE id = $1', [id]);
  return collection.rows[0];
}


module.exports = {
  insertImage,
  getImages,
  getImageById,
  getImagesByFileNames,
  countImagesByFileName,
  getCollections,
  getCollectionById,
  getCollectionByName,
  getImagesByCollection
}