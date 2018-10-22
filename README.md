# pwa-utils

[![build status](https://travis-ci.org/dk00/pwa-utils.svg)](//travis-ci.org/dk00/pwa-utils)
[![coverage](https://codecov.io/gh/dk00/pwa-utils/branch/master/graph/badge.svg)](//codecov.io/gh/dk00/pwa-utils)
[![npm](https://img.shields.io/npm/v/pwa-utils.svg)](//npm.im/pwa-utils)
[![dependencies](https://david-dm.org/dk00/pwa-utils/status.svg)](//david-dm.org/dk00/pwa-utils)

Generate `manifest.json`, `index.html`, `favicon.png` for creating Progressive Web Apps.

## Installation

Install the package with npm:

`$ npm i -D pwa-utils`

## Usage

Add the plugin to webpack config:

```diff
+ const {GenerateWebApp} = require('pwa-utils')
  module.exports = {
    entry: 'index.js',
    output: {
      path: __dirname + '/dist',
      filename: 'bundle.js'
    },
+   plugins: [
+     new GenerateWebApp({
+       name: 'My App'
+     })
+   ]
  }
```

and add runtime into your entry file:

```js
import {setupWebApp} from 'pwa-utils'
setupWebApp()
```

This will copy `src/favicon.png` to `dist/` and generate `dist/manifest.json`, `dist/index.html`:

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <title>My App</title>
  <meta charset="utf-8" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="theme-color" content="#00000" />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <link rel="manifest" href="/manifest.json" />
  <link rel="shortcut icon" href="/favicon.png" />
</head>

<body>
  <div id="root"></div>
  <script src="bundle.js"></script>
</body>

</html>
```

## Options

**`name`**

**inlineFirstRender** (Coming soon)

(true | false, default: true)

Add rendered HTML to root element of `index.html`, to get first meaningful paint before js is loaded.

**inlineCritical** (Coming soon)

(true | false | string, default: true)

Inline `index.css` or specified file to reduce render-blocking.


**scripts / styles**

Override scripts or stylesheets to be included in `index.html`.

[`manifest.json` options](https://developers.google.com/web/fundamentals/web-app-manifest/):

`shortName`, `icons`, `backgroundColor`, `themeColor`, `startUrl`

Default options is:

```yml
icons: [
  {
    src: '/favicon.png'
    type: 'image/png'
    sizes: '192x192'
  }
  {
    src: '/favicon.png'
    type: 'image/png'
    sizes: '512x512'
  }
]
display: 'standalone'
backgroundColor: '#000000'
themeColor: '#000000'
startUrl: '/?source=pwa'
```

## Technical

`emit` event of Webpack is hooked to add `.js` / `.css` assets.

Js bundles need to be includes in proper order to work correctly, so these are sorted topologically.

CSS files are added in original order.