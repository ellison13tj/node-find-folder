// Generated by CoffeeScript 1.8.0
'use strict';
var cfg, gulp, run_sequence;

cfg = require('../config.json');

gulp = require('gulp');

run_sequence = require('run-sequence');

gulp.task('default', function(cb) {
  run_sequence(['coffeescript'], ['watch'], cb);
});