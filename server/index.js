import 'dotenv/config';
import express from 'express';
import { supabase } from './supabase.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Let the server read JSON data sent from the browser
app.use(express.json());

// Serve the files in the "public" folder (your web page)
app.use(express.static('public'));

// Health check: confirms the server is running and can reach the database
app.get('/api/health', async (req, res) => {
  const { count, error } = await supabase
    .from('categories')
    .select('*', { count: 'exact', head: true });

  if (error) {
    console.error('Database check failed:', error.message);
    return res.status(500).json({ status: 'error', message: 'Could not reach the database' });
  }

  res.json({ status: 'ok', categories: count });
});

// Start listening for requests
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});



