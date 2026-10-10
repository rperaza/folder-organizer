import { createClient } from '@supabase/supabase-js';

// Read  the settings from the .env file
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseSecretKey = process.env.SUPABASE_SECRET_KEY;

// stop immediately with a clear message if a setting is missing
if (!supabaseUrl || !supabaseSecretKey) {
    throw new Error('Missing SUPABASE_URL or SUPABASE_SECRET_KEY in environment variables');
}

// Create one connection to Supabase that the whole server shares
export const supabase = createClient(supabaseUrl, supabaseSecretKey, {
    auth: {
        persistSession: false,
        autoRefreshToken: false,
    },
});