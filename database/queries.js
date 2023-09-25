const dotenv = require('dotenv')

let envPath = process.env.NODE_ENV == 'production' ?  '.env.pro':'.env.dev'
dotenv.config({path: envPath})
console.log('\tENVIRONMENT:')
console.log(process.env)

const fileSystem = require('../filesystem')

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: process.env.DBHOST || '192.168.1.56',
  database: 'postgres',
  password: 'Cashimba01',
  port: process.env.DBPORT || 4000,
})
//NEED TO IMPLEMENT ERROR HANDLING WHEN DB DOESNT CONNECT!!
//NEED TO CHECK FILESYSTEM STATE TO BE COHERENT WITH DB STATE
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
  const image = await fileSystem.parseFile(filePath)
  let collectionName = image.id_collection
  image.id_collection = await getCollectionIdByName(collectionName)
  let result =  await pool.query('INSERT into images (id,title, keywords, id_collection, height, width, date_publish, download, file_name, active) VALUES (nextval(\'images_id\'),$1,$2,$3,$4,$5,$6,$7,$8) RETURNING *',Object.values(image));
  return result.rows[0];
}

async function updateImage(filePath){
  const image = await fileSystem.parseFile(filePath)
  const collectionName = image.id_collection
  const newTitle = image.title
  const newKeywords = image.keywords
  const newIdCollection = await getCollectionIdByName(collectionName)
  let result =  await pool.query('UPDATE images SET title = $1, keywords=$2, id_collection=$3, active=true WHERE file_name = $4 ',[newTitle, newKeywords,newIdCollection,image.file_name])
  return result.rows[0];
}

async function insertCollection(name){
  await pool.query('BEGIN')
  let result =  await pool.query('INSERT into collections (id,name) VALUES (nextval(\'collect_id\'),$1) RETURNING *',[name]);
  console.log('inserted collection ', result.rows[0])
  await pool.query('COMMIT')
  return result.rows[0];
}


async function getImagesByCollection(idCollection){
  let images = await pool.query('SELECT * FROM images WHERE id_collection = $1 AND active = true', [idCollection]);
  return images.rows;
}

async function getImagesByKeywords(keywords){
  let images = await pool.query('SELECT * FROM images WHERE keywords like $1 AND active = true', [`${keywords}%`]);
  return images.rows;
}

async function getImagesNoCollection(){
  let images = await pool.query('SELECT * FROM images WHERE active = false')
  return images.rows;
}

async function getCollections(){
  let collections = await pool.query('SELECT * FROM collections ORDER BY id ASC');
  return collections.rows;
}

async function getCollectionById(id){
  let collection = await pool.query('SELECT * FROM collections WHERE id = $1', [id]);
  return collection.rows[0];
}

async function getCollectionIdByName(name){
  let collection = await pool.query('SELECT * FROM collections WHERE name like $1', [name]);
  if(collection.rows.length > 1){
    console.error('collection "'+name+'" already exists')
    return 0
  }else{
    return collection.rows[0]?.id;
  }
}

async function getCollectionNameById(id){
  let collection = await pool.query('SELECT * FROM collections WHERE id = $1', [id]);
  return collection.rows[0].name;
}

async function deleteImage(id){
  let deleted = await pool.query('UPDATE images SET active = false WHERE id = $1 ',[id]);
  return deleted.rows;
}

module.exports = {
  deleteImage,
  insertImage,
  updateImage,
  insertCollection,
  getImages,
  getImageById,
  getImagesByFileNames,
  countImagesByFileName,
  getCollections,
  getCollectionById,
  getCollectionIdByName,
  getCollectionNameById,
  getImagesByCollection, 
  getImagesByKeywords,
  getImagesNoCollection
}