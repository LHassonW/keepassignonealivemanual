const { chromium } = require('playwright');
const path = require('path');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  try {
    console.log('🌐 Navigating to login page...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/login', { waitUntil: 'networkidle' });

    // 1. Enter the password
    console.log('🔑 Entering password...');
    await page.fill('#password', 'Almaty');

    // 2. Wait a moment (as requested)
    await page.waitForTimeout(2000);

    // 3. Upload the file
    console.log('file_uploading Uploading file...');
    // We point to the dummy.sql file you created in Step 1
    await page.setInputFiles('#sql-file', 'dummy.sql');

    // 4. Click the Submit button
    console.log('🖱️ Clicking Upload and Grade...');
    // We use the button type="submit"
    await page.click('button[type="submit"]');

    // Wait to see if it moves to a success page
    await page.waitForTimeout(5000);
    console.log('✅ Action completed. Current URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed:', error);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
