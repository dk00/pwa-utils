import
  './toposort': toposort
  './manifest': manifest
  './html': html

function webpack-asset source
  source: -> source
  size: -> source.length

function html-props {chunk-groups, assets} {prefix='/' public-path=prefix}
  #TODO cases to generate groups
  nodes = Object.assign ...chunk-groups.map ->
    (it.id): it.get-parents!map (.id)
  group-ref = Object.assign ...chunk-groups.map -> (it.id): it
  sorted-groups = toposort nodes .map (group-ref.)
  file-list = []concat ...sorted-groups.map ->
    []concat ...it.chunks.map (.files)
  merged = Object.assign {} assets, ...file-list.map -> (it): true
  list = Object.keys merged .map -> prefix + it

  favicon: "#{public-path}favicon.png"
  manifest: "#{public-path}manifest.json"
  styles: list.filter /.css$/~test
  scripts: list.filter /.js$/~test

function generate compilation, options
  props = Object.assign {} (html-props compilation, options), options
  'index.html': webpack-asset html {props}
  'manifest.json': webpack-asset JSON.stringify (manifest options),, 2

!function GenerateWebApp options
  @options = options

GenerateWebApp::apply = (compiler) ->
  compiler.hooks.emit.tap \generate-web-app ({assets}: compilation) !~>
    Object.assign assets, generate compilation, @options

export default: GenerateWebApp
