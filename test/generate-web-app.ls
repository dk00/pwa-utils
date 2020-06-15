import
  path: {join}
  webpack
  './run-webpack': run-webpack
  'pnp-webpack-plugin': PnpWebpackPlugin
  'mini-css-extract-plugin': MiniCssExtractPlugin
  '../src/generate-web-app': GenerateWebApp

function load-index fs
  cheerio.load <| fs.read-file-sync (join output-path, \index.html) .to-string!

output-path = join process.cwd!, \www

async function main t
  output-path = join process.cwd!, \www
  options =
    entry: \./test/fixtures/entry.js
    output: path: output-path
    resolve: plugins: [PnpWebpackPlugin]
    resolve-loader: plugins: [PnpWebpackPlugin.module-loader module]
    module: rules:
      * test: /\.css$/
        use:
          MiniCssExtractPlugin.loader
          \css-loader
      ...
    plugins:
      new MiniCssExtractPlugin \styles.css
      new GenerateWebApp prefix: '' content: -> \content
    optimization:
      runtime-chunk: \single
      split-chunks:
        chunks: \all
        automatic-name-delimiter: \.

  run-webpack options .then (fs) ->
    result =
      index: fs.read-file-sync (join output-path, \index.html) .to-string!
      manifest: fs.read-file-sync (join output-path, \manifest.json) .to-string!

    t {
      given: 'webpack compilation'
      should: 'emit manifest and index.html'
      actual: [\index \manifest]every -> it of result
      expected: true
    }

export default: main