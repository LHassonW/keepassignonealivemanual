const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  try {
    console.log('🌐 Navigating to login page...');
    // We give the page a long time to load in case of the InfinityFree security screen
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/login', { 
      waitUntil: 'networkidle', 
      timeout: 90000 
    });

    // 1. WAIT for the password box to actually appear
    console.log('⏳ Waiting for password box to load...');
    await page.waitForSelector('#password', { state: 'visible', timeout: 30000 });

    // 2. Enter the password
    console.log('🔑 Entering password...');
    await page.fill('#password', 'Almaty');

    await page.waitForTimeout(2000);

    // 3. Upload the file
    console.log('📁 Uploading file...');
    // Ensure 'dummy.sql' exists in your GitHub repo!
    await page.setInputFiles('#sql-file', 'dummy.sql');

    // 4. Click the Submit button
    console.log('🖱️ Clicking Upload and Grade...');
    await page.click('button[type="submit"]');

    // Wait to see the result
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
