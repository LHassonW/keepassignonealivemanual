const { chromium } = require('playwright');
const fs = require('fs');

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();

  const fileName = 'dummy.sql'; 
  if (!fs.existsSync(fileName)) {
    console.error(`❌ ERROR: File "${fileName}" not found!`);
    process.exit(1);
  }

  try {
    console.log('🌐 Navigating...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { waitUntil: 'networkidle' });

    console.log('🔑 Entering password...');
    await page.locator('#password').fill('Almaty');

    console.log('📁 Locating file input...');
    // We use the ID you gave: sql-file
    const fileInput = page.locator('#sql-file');
    
    // This is the "Magic" line: 
    // It attaches the file even if the element is hidden/transparent
    await fileInput.setInputFiles(fileName);

    console.log('🖱️ Clicking Upload button...');
    // Using the button type submit to be safe
    await page.click('button[type="submit"]');

    console.log('⏳ Waiting for success...');
    await page.waitForTimeout(10000);
    
    console.log('✅ Action Successful! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
