const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage();

  try {
    console.log('🌐 Navigating to login page...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/login', { 
      waitUntil: 'networkidle', 
      timeout: 60000 
    });

    // 1. Enter the password using the ID we found earlier
    console.log('🔑 Entering password...');
    // We use a "locator" which is more robust
    const passwordInput = page.locator('#password');
    await passwordInput.waitFor({ state: 'visible' });
    await passwordInput.fill('Almaty');

    await page.waitForTimeout(2000);

    // 2. Upload the file
    console.log('📁 Uploading file...');
    // We try to find the file input by its type if the ID is failing
    const fileInput = page.locator('input[type="file"]');
    await fileInput.setInputFiles('dummy.sql');

    // 3. Click the Submit button
    console.log('🖱️ Clicking Upload and Grade...');
    // We look for the exact text on the button
    await page.getByText('Upload and Grade SQL').click();

    console.log('⏳ Waiting for result...');
    await page.waitForTimeout(10000); 

    console.log('✅ Action Successful! Current URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Taking a screenshot for proof...');
    // This will save a picture of where the script got stuck
    await page.screenshot({ path: 'error.png' });
    console.error(error);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
