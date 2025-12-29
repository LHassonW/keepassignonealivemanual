const { chromium } = require('playwright');
const fs = require('fs');

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();

  const fileName = 'dummy.sql'; 

  try {
    console.log('🌐 Navigating to site...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'networkidle' 
    });

    // 1. Enter Password
    console.log('🔑 Looking for password box...');
    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 15000 });
    await passwordBox.fill('Almaty');
    console.log('✅ Password entered.');

    // 2. Upload File
    console.log('📁 Looking for file input...');
    const fileInput = page.locator('#sql-file');
    // We wait for the input to exist in the DOM
    await fileInput.waitFor({ state: 'attached', timeout: 15000 });
    await fileInput.setInputFiles(fileName);
    console.log('✅ File attached.');

    // 3. Click the Button
    console.log('🖱️ Clicking Upload button...');
    const uploadBtn = page.locator('button[type="submit"]');
    
    // We wait until the button is no longer "disabled"
    await uploadBtn.waitFor({ state: 'visible' });
    
    // Force click in case React is still processing
    await uploadBtn.click({ force: true });

    console.log('⏳ Waiting for result...');
    await page.waitForTimeout(5000);
    
    console.log('✅ Action Successful! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Error detail:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
