// Import the Express framework for building web applications
import express from 'express';
 
// Create an Express application instance
const app = express();

// Set the port number: use environment variable PORT if available, otherwise default to 3000
// This allows flexibility when deploying to different environments
const port = process.env.PORT || 3000;
 
// Define the main endpoint - responds to GET requests at the root path '/'
app.get('/', (req, res) => {
  // Send a JSON response with service information
  res.json({ 
    message: 'Hello, from a container',     // Welcome message
    service: 'hello-node',                  // Service identifier
    pod: process.env.POD_NAME || 'unknown', // Pod name from Kubernetes (if available)
    time: new Date().toISOString(),         // Current timestamp in ISO format
   });
});

// Readiness probe endpoint - tells Kubernetes when the app is ready to receive traffic
// Kubernetes will wait for this endpoint to return 200 before sending requests to the pod
app.get('/readyz', (req, res) => res.status(200).send('ready'));

// Health check endpoint - tells Kubernetes if the app is still running properly
// Kubernetes will restart the pod if this endpoint fails
app.get('/healthz', (req, res) => res.status(200).send('ok'));

// Start the Express server and listen on the specified port
app.listen(port, () => {
  // Log a message to the console when the server starts successfully
  console.log(`Example app listening at http://localhost:${port}`);
});