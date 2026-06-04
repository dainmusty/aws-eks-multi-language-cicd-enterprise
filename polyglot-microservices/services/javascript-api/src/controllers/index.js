// Controller functions for handling requests

const getItems = (req, res) => {
  res.json({ items: [], message: 'Get all items' });
};

const createItem = (req, res) => {
  const { name, description } = req.body;
  res.status(201).json({ id: 1, name, description, message: 'Item created' });
};

const getItemById = (req, res) => {
  const { id } = req.params;
  res.json({ id, name: 'Item Name', description: 'Item description' });
};

const updateItem = (req, res) => {
  const { id } = req.params;
  const { name, description } = req.body;
  res.json({ id, name, description, message: 'Item updated' });
};

const deleteItem = (req, res) => {
  const { id } = req.params;
  res.json({ id, message: 'Item deleted' });
};

module.exports = {
  getItems,
  createItem,
  getItemById,
  updateItem,
  deleteItem,
};
