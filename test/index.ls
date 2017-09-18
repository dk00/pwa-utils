import
  path: {join}
  tape: test
  cheerio
  webpack
  \./run-webpack : run-webpack
  \extract-text-webpack-plugin : ExtractTextPlugin
  \../src/index : HtmlPlugin
  \../src/toposort : toposort

output-path = join process.cwd!, \www
function load-index fs
  cheerio.load <| fs.read-file-sync (join output-path, \index.html) .to-string!

test 'Topological sort' (t) ->
  nodes =
    \0 : []
    \1 : <[0 2]>
    \2 : <[0]>

  actual = toposort nodes
  expected = <[0 2 1]>
  t.same actual, expected
  t.end!

test 'Generate a index.html file to serve single chunk' (t) ->
  options =
    entry: \./test/fixtures/entry.js
    output:
      path: output-path
      filename: \bundle.js
    module: rules:
      * test: /\.css$/
        use: [\css-hot-loader]concat ExtractTextPlugin.extract use: [\css-loader]
      ...
    plugins:
      new ExtractTextPlugin \styles.css
      new HtmlPlugin {}

  run-webpack options .then load-index .then ($) ->
    actual = $ \#root .length > 0
    t.ok actual, 'have root element in body'

    actual = $ \script .attr \src
    expected = \bundle.js
    t.is actual, expected, 'serve the generated bundle'

    actual = $ 'link[rel=stylesheet]' .attr \href
    expected = \styles.css
    t.is actual, expected, 'serve extracted style files'

    t.end!
  .catch -> console.log it?compilation?errors || it

test 'Generate a index.html file to serve multiple chunks' (t) ->
  chunks = <[vendor runtime]>
  options =
    entry:
      main: \./test/fixtures/entry.js
      vendor: <[vhtml]>
    output:
      path: output-path
      filename: '[name].js'
    module: rules:
      * test: /\.css$/
        use: [\css-hot-loader]concat ExtractTextPlugin.extract use: [\css-loader]
      ...
    plugins:
      new ExtractTextPlugin \styles.css
      ...chunks.map (name) -> new webpack.optimize.CommonsChunkPlugin {name}
      new HtmlPlugin {}
  run-webpack options .then load-index .then ($) ->
    actual = $ \script .get!map (.attribs.src) .join ' '
    expected = 'runtime.js vendor.js main.js'
    t.is actual, expected, 'load chunks ordered by their dependencies'
    t.end!
  .catch -> console.log it?compilation?errors || it
