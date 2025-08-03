// require('dotenv').config();

// // require mongoose
// const mongoose = require('mongoose');
// // connect to database
// mongoose.connect(process.env.mongoDbUrl);

// // acquire the connection (to check if it is successful)
// const db = mongoose.connection;
// // check for error
// db.on('error', console.error.bind(console, 'connection error:'));
// // once connection is open, log to console
// db.once('open', function() {
//     console.log('connected to database');
// });

require('dotenv').config();
const mongoose = require('mongoose');

// Load connection URL from env OR fallback to direct string
const mongoDbUrl = process.env.mongoDbUrl || "mongodb+srv://amirbasiony14:11112222@cluster-1.tzme51z.mongodb.net/?retryWrites=true&w=majority&appName=Cluster-1";

// Connect to MongoDB
mongoose.connect(mongoDbUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// Acquire connection
const db = mongoose.connection;

// Check for connection errors
db.on('error', (error) => {
  console.error('❌ MongoDB connection error:', error.message);
});

// Log successful connection
db.once('open', () => {
  console.log('✅ Connected to MongoDB database!');
});
