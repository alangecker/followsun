gulp = require 'gulp'
gutil = require 'gulp-util'
gwebpack = require 'gulp-webpack'
sass = require 'gulp-sass'
path = require 'path'
BowerWebpackPlugin = require 'bower-webpack-plugin'

handleError = (err) ->
    console.log err
    this.emit('end') if this.emit


modules_path = "node_modules"

err = (x...) -> gutil.log(x...); gutil.beep(x...)




js = (watch) ->
  options =
#    bail: true
    watch: watch
    cache: true
    devtool: "source-map"
    output:
      filename: 'app.js'
      sourceMapFilename: "[file].map"
    resolve:
      extensions: ["", ".webpack.js", ".web.js", ".js", ".jsx", ".coffee", ".cjsx"]
      modulesDirectories: [modules_path]
    module:
      loaders: [
        {
          test: /\.coffee$/
          loader: "coffee-loader"
        }
        {
          test: [/\.js$/, /\.jsx$/]
          exclude: [new RegExp(modules_path)]
          loader: "babel-loader"
        }
        {
          test: /\.cjsx$/
          loader: "transform?coffee-reactify"
        }
      ]

  gulp.src('./frontend/components/app.cjsx')
  .pipe(gwebpack(options))
  .pipe(gulp.dest('./frontend/dist/js'))

gulp.task 'js', -> js(false)

gulp.task 'js-dev', -> js(true)


gulp.task 'sass', ->
  gulp.src('./frontend/styles/app.sass')
  .pipe(sass().on('error', sass.logError))
  .pipe(gulp.dest('./frontend/dist/css'));

gulp.task 'watch', ->
    gulp.watch('./frontend/components/**/**/**/*.cjsx', ['js']).on('error', handleError)
    gulp.watch('./frontend/components/**/**/**/*.coffee', ['js']).on('error', handleError)
    gulp.watch('frontend/styles/**/*.sass', ['sass']).on('error', handleError)



gulp.task('default', ['js', 'sass', 'watch']);
