const express = require('express');
const app = express();

// Define routes
app.get('/', (req, res) => {
    res.send('Hello from Example Web App Backend!');
});

// Start server
const PORT = process.env.PORT || 8081;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

// Export the Express app
module.exports = app;
