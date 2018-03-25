module.exports = {
  presets: ['@babel/stage-0'],
  plugins: [
    'livescript',
    ['@babel/transform-react-jsx', { pragma: 'h', useBuiltIns: true }]
  ]
}
