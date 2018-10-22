import './template': factory

function html {props}
  h = require \preact .h
  render = require \preact-render-to-string

  '<!DOCTYPE html>\n' + render (factory h) props

export default: html