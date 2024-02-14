// Import your Express app
const app = require('./index'); // Assuming your Express app is in app.js

// Define a port number for your local server
const PORT = 3000;

// Start the local server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
