const { chromium } = require('playwright');

(async () => {
  // Launch browser with a realistic User Agent to help bypass basic bot filters
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();

  const fileName = 'dummy.sql'; 

  try {
    console.log('🌐 Navigating to site...');
    // 'commit' is used because it triggers as soon as the server responds, 
    // bypassing the wait for slow background scripts.
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'commit', 
      timeout: 90000 
    });

    // Wait for the InfinityFree security challenge to process and show the password field
    console.log('🔑 Waiting for password box to appear...');
    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 45000 });
    
    await passwordBox.fill('Almaty');
    await passwordBox.press('Enter'); 
    console.log('✅ Password entered and submitted.');

    // Wait for the next page to load after the password
    console.log('⏳ Waiting for file input to appear...');
    const fileInput = page.locator('#sql-file');
    await fileInput.waitFor({ state: 'visible', timeout: 30000 });
    
    console.log('📁 Attaching file...');
    await fileInput.setInputFiles(fileName);
    console.log('✅ File attached.');

    console.log('鼠标 Clicking Upload button...');
    const uploadBtn = page.locator('button[type="submit"]');
    await uploadBtn.click({ force: true });

    // Final wait to ensure the upload is processed by the server
    console.log('⏳ Waiting for final result...');
    await page.waitForTimeout(8000);
    
    console.log('✅ Action Successful! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Error detail:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
