import './template': factory

function get-react
  try return {
    create-element: require \react .create-element
    render-to-string: require 'react-dom/server' .render-to-string
  }
  create-element: require \preact .h
  render-to-string: require \preact-render-to-string

function html {props, React=get-react!}
  {create-element, render-to-string} = React
  '<!DOCTYPE html>\n' + render-to-string (factory create-element) props

export default: html
