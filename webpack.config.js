const VueLoaderPlugin = require('vue-loader/lib/plugin')

// webpack.config.js
module.exports = {
    mode: 'development',
    // メインとなるソースファイル
    entry: './src/index.js',
    // 出力設定
    // この場合はdest/bundle.jsというファイルが生成される
    output: {
        // 出力先のファイル名
        filename: 'bundle.js',
        // 出力先のファイルパス
        path: `${__dirname}`,
    },
    module: {
      rules: [
        {
          test: /\.vue$/,
          loader: 'vue-loader',
        },
        {
          test: /\.js$/,
          loader: 'babel-loader?presets=es2015',
        },
        {
          test: /\.scss$/,
          loaders: [
            'style-loader',
            'css-loader',
            'sass-loader'
          ]
        },
      ]
    },
    resolve: {
      extensions: ['.js', '.vue'],
      alias: {
        vue$: 'vue/dist/vue.esm.js',
      },
    },
    // 開発サーバの設定
    devServer: {
    },
    plugins: [
      // make sure to include the plugin!
      new VueLoaderPlugin()
    ]
}