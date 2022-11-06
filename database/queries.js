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

const getImagesByCollection = (request, response) => {
  const idCollection = parseInt(request.params.idCollection)

  pool.query('SELECT * FROM images WHERE id_collection = $1', [idCollection], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
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

  pool.query('SELECT * FROM collections WHERE id = $1', [id], (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}


module.exports = {
  getImages,
  getImageById,
  getCollections,
  getCollectionById,
  getImagesByCollection
}