#!/usr/bin/env node

// Simple Playwright-based scraper that bypasses bot detection
// Usage: node scraper.js <url>

const { chromium } = require('playwright');

async function fetchPage(url) {
  // Use headless: false or use new headless mode which is less detectable
  const browser = await chromium.launch({ 
    headless: false,  // Non-headless mode to avoid bot detection
    args: ['--disable-blink-features=AutomationControlled']  // Hide automation
  });
  
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36',
    viewport: { width: 1920, height: 1080 },
    locale: 'en-US',
    timezoneId: 'America/New_York',
  });
  
  const page = await context.newPage();
  
  // Hide webdriver property
  await page.addInitScript(() => {
    Object.defineProperty(navigator, 'webdriver', {
      get: () => undefined
    });
  });
  
  try {
    // Navigate with a realistic timeout
    await page.goto(url, { 
      waitUntil: 'domcontentloaded', 
      timeout: 30000 
    });
    
    // Wait a bit to let page fully load
    await page.waitForTimeout(2000);
    
    const content = await page.content();
    console.log(content);
    await browser.close();
    process.exit(0);
  } catch (error) {
    console.error(`Error fetching ${url}: ${error.message}`);
    await browser.close();
    process.exit(1);
  }
}

const url = process.argv[2];
if (!url) {
  console.error('Usage: node scraper.js <url>');
  process.exit(1);
}

fetchPage(url);
