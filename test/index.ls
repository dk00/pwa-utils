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

function report-error => console.log it?compilation?errors || it

test 'Topological sort' (t) ->
  nodes =
    \1 : <[0 2]>
    \2 : <[0]>
    \0 : []

  actual = toposort nodes
  expected = <[0 2 1]>
  t.same actual, expected

  nodes = \0 : [\2] \1 : [\2] \2 : []
  actual = toposort nodes
  expected = <[2 1 0]>
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
        use: ExtractTextPlugin.extract use: [\css-loader]
      ...
    plugins:
      new ExtractTextPlugin \styles.css
      new HtmlPlugin {}

  run-webpack options .then load-index .then ($) ->
    actual = $ \#root .length > 0
    t.ok actual, 'have root element in body'

    actual = $ \script .attr \src
    expected = \/bundle.js
    t.is actual, expected, 'serve the generated bundle'

    actual = $ 'link[rel=stylesheet]' .attr \href
    expected = \/styles.css
    t.is actual, expected, 'serve extracted style files'

    t.end!
  .catch report-error

test 'Generate a index.html file to serve multiple chunks' (t) ->
  options =
    entry: \./test/fixtures/entry.js
    output: path: output-path
    module: rules:
      * test: /\.css$/
        use:
          * loader: \file-loader options: name: '[name].css'
          \extract-loader
          \css-loader
      ...
    plugins:
      new ExtractTextPlugin \styles.css
      new HtmlPlugin prefix: '' content: -> \content
    optimization:
      runtime-chunk: \single
      split-chunks:
        chunks: \all
        automatic-name-delimiter: \.

  run-webpack options .then load-index .then ($) ->
    chunks = $ \script .get!map (.attribs.src)

    actual = chunks.length > 1
    t.ok actual, 'split into some chunks'

    actual = chunks.slice -1 .0
    expected = \main.js
    t.is actual, expected, 'load main chunk at last'

    actual = $ \link .get!map (.attribs.href)
    .filter (.ends-with \css) .join ' '
    expected = \reset.css
    t.is actual, expected, 'inject css files generated with file-loader'

    actual = $ \#root .text!trim!
    expected = \content
    t.is actual, expected, 'add content to generated html'

    t.end!
  .catch report-error
