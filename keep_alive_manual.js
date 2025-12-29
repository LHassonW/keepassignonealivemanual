const { chromium } = require('playwright');
const fs = require('fs');

(async () => {
  const browser = await chromium.launch();
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });
  const page = await context.newPage();

  // CHECK: Does the file actually exist in the repo?
  const fileName = 'dummy.sql'; 
  if (!fs.existsSync(fileName)) {
    console.error(`❌ ERROR: The file "${fileName}" was not found in your GitHub repository!`);
    process.exit(1);
  }

  try {
    console.log('🌐 Navigating...');
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { waitUntil: 'networkidle' });

    console.log('🔑 Entering password...');
    await page.locator('#password').fill('Almaty');
    await page.waitForTimeout(1000);

    console.log('📁 Uploading file...');
    // This finds the input even if the ID is being tricky
    const fileInput = page.locator('input[type="file"]');
    await fileInput.setInputFiles(fileName);

    console.log('🖱️ Clicking Upload button...');
    // Using the button text is often more reliable than the class list
    await page.locator('button:has-text("Upload and Grade SQL")').click();

    console.log('⏳ Waiting for success...');
    await page.waitForTimeout(8000);
    
    console.log('✅ Action Successful! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed:');
    console.error(error.message);
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
