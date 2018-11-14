import './template': factory

function get-react
  try return {
    create-element: require \react .create-element
    render: require 'react-dom/server' .render-to-string
  }
  create-element: require \preact .h
  render: require \preact-render-to-string

function html {props, React=get-react!}
  {create-element, render} = React
  '<!DOCTYPE html>\n' + render (factory create-element) props

export default: html
