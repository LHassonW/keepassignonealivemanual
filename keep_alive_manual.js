const { chromium } = require('playwright');

(async () => {
  // 1. Launch browser with a "Real Person" identity (User Agent)
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();

  try {
    console.log('🌐 Navigating to the site...');
    // Updated to the main URL
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'networkidle', 
      timeout: 90000 
    });

    // 2. Wait for the password box to appear
    console.log('⏳ Waiting for password box to load...');
    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 30000 });

    // 3. Enter the password
    console.log('🔑 Entering password...');
    await passwordBox.fill('Almaty');

    await page.waitForTimeout(2000);

    // 4. Upload the file
    console.log('📁 Uploading file...');
    // Ensure 'dummy.sql' exists in your GitHub repo!
    await page.setInputFiles('#sql-file', 'dummy.sql');

    // 5. Click the Submit button
    console.log('🖱️ Clicking Upload and Grade...');
    await page.click('button[type="submit"]');

    // Wait for the server to process the upload
    console.log('⏳ Waiting for success page...');
    await page.waitForTimeout(10000);
    
    console.log('✅ Action Successful! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Printing error details:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
