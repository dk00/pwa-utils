import
  \rollup-plugin-node-resolve : resolve
  \rollup-plugin-babel : babel

targets =
  * \src/index.ls \dist/index.esm.js \es
  * \src/index.ls \dist/index.js \iife
  * \src/index.ls \lib/index.js \cjs

name = \PWA

config-list = targets.map ([input, output, format]) ->
  input: input
  output: {name, file: output, format, sourcemap: true strict: false}
  plugins:
    resolve jsnext: true extensions: <[.ls .jsx]>
    babel!

export default: config-list
