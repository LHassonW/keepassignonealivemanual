const { chromium } = require('playwright');

(async () => {
  // 1. Launch with slightly more 'human' args
  const browser = await chromium.launch({
    args: ['--disable-blink-features=AutomationControlled']
  });

  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    viewport: { width: 1280, height: 720 }
  });

  const page = await context.newPage();
  const fileName = 'dummy.sql'; 

  try {
    console.log('🌐 Navigating to site...');
    
    // 2. Change 'commit' to 'domcontentloaded' or 'load' 
    // Free hosts often use a JS redirect for the security challenge. 
    // 'commit' might trigger too early before the redirect happens.
    await page.goto('https://assignmentonejinhuapartthreefour.great-site.net/', { 
      waitUntil: 'load', 
      timeout: 90000 
    });

    // 3. Optional: Add a small sleep to let the security challenge cookie set
    await page.waitForTimeout(5000);

    console.log('🔑 Checking for password box...');
    const passwordBox = page.locator('#password');
    
    // If the site is VERY slow, we want to see if it even loaded the right page
    try {
        await passwordBox.waitFor({ state: 'visible', timeout: 30000 });
    } catch (e) {
        console.log('Current Page Title:', await page.title());
        console.log('Current URL:', page.url());
        throw new Error('Password box not found. Site might be showing a security challenge or 403 error.');
    }
    
    await passwordBox.fill('Almaty');
    await page.keyboard.press('Enter'); 
    console.log('✅ Password submitted.');

    console.log('⏳ Waiting for file input...');
    const fileInput = page.locator('#sql-file');
    await fileInput.waitFor({ state: 'visible', timeout: 30000 });
    
    console.log('📁 Attaching file...');
    await fileInput.setInputFiles(fileName);
    
    // 4. Use standard click and wait for response
    await Promise.all([
        page.waitForNavigation({ waitUntil: 'networkidle' }).catch(() => {}),
        page.locator('button[type="submit"]').click()
    ]);

    console.log('✅ Success! Final URL:', page.url());

  } catch (error) {
    console.error('❌ Script failed. Error detail:');
    console.error(error.message);
    // Take a screenshot to see what went wrong (very helpful in GitHub Actions)
    await page.screenshot({ path: 'error_screenshot.png' });
    process.exit(1);
  } finally {
    await browser.close();
  }
})();
