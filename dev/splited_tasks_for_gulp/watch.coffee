# name: watch.js
#
# author: 沈维忠 ( Shen Weizhong / Tony Stark )
#
# Last Update: 沈维忠 ( Shen Weizhong / Tony Stark )



'use strict'



cfg    = require '../config.json'

gulp   = require 'gulp'

$      = require('gulp-load-plugins')()



gulp.task 'watch', ->

    gulp.watch 'node.find.folder.coffee',

        cwd: 'dev'

    , ['coffeescript']

    return
