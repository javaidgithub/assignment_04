const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors()); // Enable CORS
app.use(express.json());

const PORT = process.env.PORT || 3000;
// API Endpoint to Receive Data
app.post('/sendData', (req, res) => {
  const { sapId, name, program } = req.body;
  console.log('Received data:', { sapId, name, program });

  // Send back a response including the received data
  res.json({
    message: 'Data received successfully',
    receivedData: { sapId, name, program }
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
