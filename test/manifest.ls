import '../src/manifest': manifest

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
    should: 'generate manifest with default values'
    actual: manifest name: 'My App'
    expected:
      name: 'My App'
      short_name: 'My App'
      icons:
        * src: '/favicon.png'
          type: 'image/png'
          sizes: \192x192
        * src: '/favicon.png'
          type: 'image/png'
          sizes: \512x512
      display: \standalone
      background_color: \#000000
      theme_color: \#000000
      start_url: '/?source=pwa'
  }

  t {
    given: 'custom options'
    should: 'generate manifest with specified options'
    actual: manifest get-options!
    expected:
      name: 'My App'
      short_name: 'My App'
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
      background_color: \#773300
      theme_color: \#773300
      start_url: '/?source=homescreen'
  }

export default: main
