import
  \rollup-plugin-node-resolve : resolve
  \rollup-plugin-babel : babel

config =
  input: \src/index.ls output: file: \lib/index.js format: \cjs
  plugins:
    resolve jsnext: true extensions: <[.ls .jsx]>
    babel require \./.babelrc
  sourcemap: true strict: false

export default: config
