module.exports = {
  presets: ['upcoming'],
  plugins: [
    'livescript',
    ['@babel/transform-react-jsx', { pragma: 'h', useBuiltIns: true }]
  ]
}
