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

    // 1. Enter Password and press ENTER
    console.log('🔑 Looking for password box...');
    const passwordBox = page.locator('#password');
    await passwordBox.waitFor({ state: 'visible', timeout: 15000 });
    await passwordBox.fill('Almaty');
    await passwordBox.press('Enter'); // This triggers the "unlock" logic
    console.log('✅ Password entered and submitted.');

    // 2. WAIT for the file input to appear after the password unlock
    console.log('⏳ Waiting for file input to appear...');
    const fileInput = page.locator('#sql-file');
    // We give it 15 seconds to appear after the login
    await fileInput.waitFor({ state: 'visible', timeout: 15000 });
    
    console.log('📁 Attaching file...');
    await fileInput.setInputFiles(fileName);
    console.log('✅ File attached.');

    // 3. Click the final Button
    console.log('🖱️ Clicking Upload button...');
    const uploadBtn = page.locator('button[type="submit"]');
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
