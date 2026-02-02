const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({
    args: ['--disable-blink-features=AutomationControlled']
  });

  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36'
  });

  const page = await context.newPage();
  
  // Credentials
  const SUPABASE_URL = 'https://gyiclkufjjvuqlxyepft.supabase.co';
  const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd5aWNsa3Vmamp2dXFseHllcGZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2NDc4MTgsImV4cCI6MjA3NjIyMzgxOH0.JeIfmQvfS818PUlMWDXFqIPR-hZUPQWqZHolgeF1woo';

  try {
    // STEP 1: Keep the InfinityFree Website Alive
    console.log('🌐 Navigating to InfinityFree site...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'domcontentloaded', 
      timeout: 60000 
    });

    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 30000 });
    await passwordBox.fill('Almaty');
    await page.keyboard.press('Enter'); 
    
    console.log('📁 Uploading dummy.sql...');
    const fileInput = page.locator('#sql-file');
    await fileInput.waitFor({ state: 'visible' });
    await fileInput.setInputFiles('dummy.sql');
    await page.locator('button[type="submit"]').click();
    console.log('✅ Website UI interaction complete.');

    // STEP 2: Keep Supabase Database Alive (Direct Heartbeat)
    console.log('📡 Sending Direct Heartbeat to Supabase PostgREST...');
    const status = await page.evaluate(async ({ url, key }) => {
      try {
        // We call a specific table to ensure a data log is generated
        const response = await fetch(`${url}/rest/v1/live?select=id&limit=1`, {
          headers: {
            "apikey": key,
            "Authorization": `Bearer ${key}`
          }
        });
        return response.status;
      } catch (e) { return e.message; }
    }, { url: SUPABASE_URL, key: SUPABASE_KEY });

    console.log(`✅ Supabase Response: ${status} (200/404 means it saw you!)`);

  } catch (error) {
    console.error('❌ Script failed:', error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
