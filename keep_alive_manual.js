const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();
  const fileName = 'dummy.sql'; 

  try {
    console.log('🌐 Navigating to site (Attempt 1)...');
    
    // We increase the timeout to 2 minutes (120000ms)
    // Sometimes the first hit just "wakes up" the server
    try {
        await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
          waitUntil: 'commit', 
          timeout: 120000 
        });
    } catch (e) {
        console.log('⚠️ First attempt timed out, retrying immediately...');
        await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
          waitUntil: 'commit', 
          timeout: 120000 
        });
    }

    console.log('🔑 Waiting for password box...');
    const passwordBox = page.locator('#password');
    // Give the security challenge page plenty of time to resolve
    await passwordBox.waitFor({ state: 'visible', timeout: 60000 });
    
    await passwordBox.fill('Almaty');
    await passwordBox.press('Enter'); 
    console.log('✅ Password submitted.');

    console.log('⏳ Waiting for file input...');
    const fileInput = page.locator('#sql-file');
    await fileInput.waitFor({ state: 'visible', timeout: 60000 });
    
    console.log('📁 Attaching file...');
    await fileInput.setInputFiles(fileName);
    
    const uploadBtn = page.locator('button[type="submit"]');
    await uploadBtn.click({ force: true });

    // Wait longer for the PHP script to process the upload
    await page.waitForTimeout(15000);
    console.log('✅ Success! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Error detail:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
