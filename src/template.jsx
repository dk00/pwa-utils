export default h => ({
  name, title=name, styles=[], scripts=[],
  content: Content='', rootAttributes={id: 'root'},
  lang='en', themeColor='#000000', manifest='/manifest.json', favicon='/favicon.png'
}) =>
<html lang={lang}>

<head>
  <title>{title}</title>
  <meta charSet="utf-8" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="theme-color" content={themeColor} />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <link rel="manifest" href={manifest} />
  <link rel="shortcut icon" href={favicon} />
  {styles.map(href =>
    <link key={href} rel="stylesheet" href={href} />
  )}
</head>

<body>
  <div {...rootAttributes}>
    {typeof Content === 'string'? Content: <Content />}
  </div>
  {scripts.map(src =>
    <script key={src} src={src}></script>
  )}
</body>

</html>
