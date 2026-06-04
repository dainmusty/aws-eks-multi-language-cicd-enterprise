const helmet = require('helmet');
const morgan = require('morgan');

const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(morgan('combined'));
app.use(express.json());

// Routes
const routes = require('./routes');
app.use('/api', routes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', service: 'javascript-api' });
});

// Start server
app.listen(PORT, () => {
  console.log(`JavaScript API service running on port ${PORT}`);
});

module.exports = app;

// ############################################################
// GRACEFUL SHUTDOWN
//
// Kubernetes sends SIGTERM during rolling updates.
// This allows clean shutdown.
// ############################################################

process.on("SIGTERM", () => {
  console.log("SIGTERM received. Shutting down gracefully...");
  process.exit(0);
});

process.on("SIGINT", () => {
  console.log("SIGINT received. Shutting down gracefully...");
  process.exit(0);
});