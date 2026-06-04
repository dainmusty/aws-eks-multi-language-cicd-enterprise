const express = require('express');
const router = express.Router();
const controllers = require('../controllers');

// API routes
router.get('/items', controllers.getItems);
router.post('/items', controllers.createItem);
router.get('/items/:id', controllers.getItemById);
router.put('/items/:id', controllers.updateItem);
router.delete('/items/:id', controllers.deleteItem);

module.exports = router;
