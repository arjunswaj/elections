#!/usr/bin/env node

// Playwright-based batch scraper that bypasses bot detection
// Usage: node scraper.js <url1> <url2> <url3> ...
// Reads URLs from stdin if no arguments provided

const { chromium } = require('playwright');
const readline = require('readline');

async function fetchPages(urls) {
  // Launch browser once
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
  
  // Process each URL
  for (let i = 0; i < urls.length; i++) {
    const url = urls[i];
    try {
      console.error(`[${i + 1}/${urls.length}] Fetching: ${url}`);
      
      // Navigate to the page
      await page.goto(url, { 
        waitUntil: 'domcontentloaded', 
        timeout: 30000 
      });
      
      // Wait a bit to let page fully load
      await page.waitForTimeout(1000);
      
      const content = await page.content();
      
      // Output with delimiter
      console.log('===URL_START===');
      console.log(url);
      console.log('===CONTENT_START===');
      console.log(content);
      console.log('===CONTENT_END===');
      
    } catch (error) {
      console.error(`Error fetching ${url}: ${error.message}`);
      console.log('===URL_START===');
      console.log(url);
      console.log('===CONTENT_START===');
      console.log(`ERROR: ${error.message}`);
      console.log('===CONTENT_END===');
    }
  }
  
  await browser.close();
  console.error('All pages fetched successfully');
}

async function readUrlsFromStdin() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
  });

  const urls = [];
  for await (const line of rl) {
    const trimmed = line.trim();
    if (trimmed) {
      urls.push(trimmed);
    }
  }
  return urls;
}

async function main() {
  let urls;
  
  if (process.argv.length > 2) {
    // URLs provided as command line arguments
    urls = process.argv.slice(2);
  } else {
    // Read URLs from stdin
    urls = await readUrlsFromStdin();
  }
  
  if (urls.length === 0) {
    console.error('Usage: node scraper.js <url1> <url2> ... OR pipe URLs via stdin');
    process.exit(1);
  }
  
  await fetchPages(urls);
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
