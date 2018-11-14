import '../src/html': html

function get-options
  name: 'My App'
  icons:
    * src: '/favicon.png'
      type: 'image/png'
      sizes: \192x192
    * src: '/favicon.png'
      type: 'image/png'
      sizes: \256x256
    * src: '/favicon.png'
      type: 'image/png'
      sizes: \512x512
  display: \fullscreen
  backgroundColor: \#773300
  themeColor: \#773300
  startUrl: '/?source=homescreen'

async function main t
  t {
    given: 'simple options'
    should: 'generate html for PWA'
    actual: html props: get-options!
    expected: '<!DOCTYPE html>\n<html lang="en"><head><title>My App</title><meta charset="utf-8" /><meta name="mobile-web-app-capable" content="yes" /><meta name="viewport" content="width=device-width, initial-scale=1.0" /><meta name="theme-color" content="#773300" /><meta name="apple-mobile-web-app-capable" content="yes" /><meta name="apple-mobile-web-app-status-bar-style" content="black" /><link rel="manifest" href="/manifest.json" /><link rel="shortcut icon" href="/favicon.png" /></head><body><div id="root"></div></body></html>'
  }

export default: main
