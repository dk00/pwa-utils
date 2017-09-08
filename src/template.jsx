export default h => ({
  title, name=title, styles, scripts, content='',
  lang="en", themeColor="#000", manifest="/manifest.json", favicon="/favicon.png"
}) =>
<html lang={lang}>

<head>
  <title>{name}</title>
  <meta charset="utf-8" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="theme-color" content={themeColor} />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <link rel="manifest" href={manifest} />
  <link rel="shortcut icon" href={favicon} />
  {styles.map(href =>
    <link rel="stylesheet" href={href} />
  )}
</head>

<body>
  <div id="root">{content}</div>
  {scripts.map(src =>
    <script src={src}></script>
  )}
</body>

</html>
