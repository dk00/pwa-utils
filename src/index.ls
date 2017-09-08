import
  \./template : default-template
  \./toposort : toposort

function create-template component
  {h} = require \preact
  render-to-string = require \preact-render-to-string
  -> '<!DOCTYPE html>\n' + render-to-string (component h) it

function webpack-asset source
  source: -> source
  size: -> source.length

function manifest {chunks}
  nodes = Object.assign ...chunks.map -> (it.id): it.parents.map (.id)
  files = Object.assign ...chunks.map -> (it.id): it.files
  parts = toposort nodes .map (files.)
  list = []concat ...parts
  styles: list.filter /.css$/~test
  scripts: list.filter /.js$/~test

function generate compilation, {title, filename=\index.html}
  props = Object.assign {title} manifest compilation
  render-template = create-template default-template
  result = render-template props
  (filename): webpack-asset result

!function HtmlPlugin options
  @options = options

HtmlPlugin::apply = (compiler) ->
  compiler.plugin \emit ({assets}: compilation, callback) ~>
    Object.assign assets, generate compilation, @options
    callback!

module.exports = HtmlPlugin
