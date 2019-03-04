function generate-icons path='/favicon.png'
  * * src: path
      type: 'image/png'
      sizes: \192x192
    * src: path
      type: 'image/png'
      sizes: \512x512

function manifest {
  name
  icons=generate-icons!
  display=\standalone
  backgroundColor=\#000000
  themeColor=\#000000
  startUrl='/?source=pwa'
}
  name: name
  short_name: name
  icons: icons
  display: display
  background_color: backgroundColor
  theme_color: themeColor
  start_url: startUrl

export default: manifest
