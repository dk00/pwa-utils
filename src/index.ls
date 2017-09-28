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

function manifest {chunks, assets}
  nodes = Object.assign ...chunks.map -> (it.id): it.parents.map (.id)
  files = Object.assign ...chunks.map -> (it.id): it.files
  sorted-chunks = toposort nodes .map (files.)
  chunk-files = []concat ...sorted-chunks
  list = Object.keys assets .filter -> !chunk-files.includes it
  .concat chunk-files
  styles: list.filter /.css$/~test
  scripts: list.filter /.js$/~test

function generate compilation, {filename=\index.html}: options
  props = Object.assign {compilation} (manifest compilation), options
  render-template = create-template default-template
  (filename): webpack-asset render-template props

!function HtmlPlugin options
  @options = options

HtmlPlugin::apply = (compiler) ->
  compiler.plugin \emit ({assets}: compilation, callback) ~>
    Object.assign assets, generate compilation, @options
    callback!

module.exports = HtmlPlugin
