module.exports = {
  "transpileDependencies": [
      "vuetify"
  ],
  configureWebpack: {
      devtool: 'source-map'
  },
  devServer: {
      host: '0.0.0.0',
      disableHostCheck: true
  }
}