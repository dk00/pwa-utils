import
  \./template : default-template
  \./toposort : toposort

function create-template component
  {h} = require \preact
  render-string = require \preact-render-to-string
  -> '<!DOCTYPE html>\n' + render-string (component h) it

function webpack-asset source
  source: -> source
  size: -> source.length

function manifest {chunk-groups, assets} {prefix=\/}
  #TODO cases to generate groups
  nodes = Object.assign ...chunk-groups.map ->
    (it.id): it.get-parents!map (.id)
  group-ref = Object.assign ...chunk-groups.map -> (it.id): it
  sorted-groups = toposort nodes .map (group-ref.)
  file-list = []concat ...sorted-groups.map ->
    []concat ...it.chunks.map (.files)
  merged = Object.assign {} assets, ...file-list.map -> (it): true
  list = Object.keys merged .map -> prefix + it
  styles: list.filter /.css$/~test
  scripts: list.filter /.js$/~test

function generate compilation, {filename=\index.html}: options
  props = Object.assign {compilation} (manifest compilation, options), options
  render-template = create-template default-template
  (filename): webpack-asset render-template props

!function HtmlPlugin options
  @options = options

HtmlPlugin::apply = (compiler) ->
  compiler.hooks.emit.tap \html-plugin ({assets}: compilation) ~>
    Object.assign assets, generate compilation, @options

module.exports = HtmlPlugin
