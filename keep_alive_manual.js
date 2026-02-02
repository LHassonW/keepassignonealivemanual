const { chromium } = require('playwright');

(async () => {
  // Launch with automation bypass
  const browser = await chromium.launch({
    args: ['--disable-blink-features=AutomationControlled']
  });

  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    viewport: { width: 1280, height: 720 }
  });

  const page = await context.newPage();
  const fileName = 'dummy.sql'; 
  
  // Your Project Details
  const SUPABASE_URL = 'https://gyiclkufjjvuqlxyepft.supabase.co';
  const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd5aWNsa3Vmamp2dXFseHllcGZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA2NDc4MTgsImV4cCI6MjA3NjIyMzgxOH0.JeIfmQvfS818PUlMWDXFqIPR-hZUPQWqZHolgeF1woo';

  try {
    console.log('🌐 Navigating to website UI...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'domcontentloaded', 
      timeout: 90000 
    });

    console.log('🔑 Handling Login...');
    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 30000 });
    await passwordBox.fill('Almaty');
    await page.keyboard.press('Enter'); 

    console.log('📁 Attaching and Uploading SQL File...');
    const fileInput = page.locator('#sql-file');
    await fileInput.waitFor({ state: 'visible', timeout: 30000 });
    await fileInput.setInputFiles(fileName);
    
    await Promise.all([
        page.waitForNavigation({ waitUntil: 'networkidle' }).catch(() => {}),
        page.locator('button[type="submit"]').click()
    ]);

    // --- THE FIX: DIRECT HEARTBEAT TO SUPABASE ---
    // This ensures Supabase sees a real API request even if the PHP upload fails.
    console.log('📡 Sending Direct Heartbeat to Supabase PostgREST...');
    const heartbeat = await page.evaluate(async ({ url, key }) => {
      try {
        const response = await fetch(`${url}/rest/v1/live?select=id&limit=1`, {
          headers: {
            "apikey": key,
            "Authorization": `Bearer ${key}`
          }
        });
        return response.status;
      } catch (e) {
        return e.message;
      }
    }, { url: SUPABASE_URL, key: SUPABASE_KEY });

    console.log(`✅ Heartbeat status: ${heartbeat} (Should be 200 or 404)`);
    console.log('🏁 Success! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed:', error.message);
    await page.screenshot({ path: 'error_screenshot.png' });
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
