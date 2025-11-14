#!/usr/bin/env node

// Playwright-based scraper server that keeps browser open
// Reads URLs from stdin and returns HTML content
// Protocol: URL on stdin -> response with delimiters on stdout

const { chromium } = require('playwright');
const readline = require('readline');

let browser = null;
let page = null;

async function initBrowser() {
  browser = await chromium.launch({ 
    headless: false,
    args: ['--disable-blink-features=AutomationControlled']
  });
  
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36',
    viewport: { width: 1920, height: 1080 },
    locale: 'en-US',
    timezoneId: 'America/New_York',
  });
  
  page = await context.newPage();
  
  await page.addInitScript(() => {
    Object.defineProperty(navigator, 'webdriver', {
      get: () => undefined
    });
  });
  
  console.error('Browser initialized');
}

async function fetchPage(url) {
  try {
    console.error(`Fetching: ${url}`);
    
    await page.goto(url, { 
      waitUntil: 'domcontentloaded', 
      timeout: 30000 
    });
    
    await page.waitForTimeout(1000);
    
    const content = await page.content();
    
    // Send response with delimiters
    console.log('===RESPONSE_START===');
    console.log(content);
    console.log('===RESPONSE_END===');
    
  } catch (error) {
    console.error(`Error: ${error.message}`);
    console.log('===ERROR_START===');
    console.log(error.message);
    console.log('===ERROR_END===');
  }
}

async function processUrls() {
  const rl = readline.createInterface({
    input: process.stdin,
    terminal: false
  });

  for await (const line of rl) {
    const url = line.trim();
    if (url) {
      await fetchPage(url);
    }
  }
}

async function main() {
  await initBrowser();
  await processUrls();
  
  console.error('Closing browser');
  if (browser) {
    await browser.close();
  }
}

main().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
