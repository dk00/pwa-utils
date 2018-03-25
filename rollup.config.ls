import
  \rollup-plugin-node-resolve : resolve
  \rollup-plugin-babel : babel

config =
  input: \src/index.ls
  output: file: \lib/index.js format: \cjs sourcemap: true strict: false
  plugins:
    resolve jsnext: true extensions: <[.ls .jsx]>
    babel require \./.babelrc

export default: config
