import
  'rollup-plugin-pnp-resolve': pnp-resolve
  '@rollup/plugin-node-resolve' : resolve
  '@rollup/plugin-babel' : babel

package-config = require './package.json'

targets =
  * \src/index.ls \es package-config.module
  * \src/index.ls \iife package-config.unpkg
  * \src/index.ls \cjs package-config.main

name = \PwaUtils

config-list = targets.map ([input, format, output]) ->
  input: input
  output: {name, file: output, format, sourcemap: true strict: false}
  plugins:
    pnp-resolve!
    resolve jsnext: true extensions: <[.ls .jsx]>
    babel extensions: ['.ls' '.jsx' '.js'] babel-helpers: \runtime skip-preflight-check: true

export default: config-list
