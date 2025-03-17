const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Serve static files like CSS from the 'public' directory
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
    res.send('<h1>Welcome to Trainee Backend!</h1><p>This is a basic backend server.</p>');
});

app.listen(port, () => {
    console.log(`Backend is running at http://localhost:${port}`);
});

