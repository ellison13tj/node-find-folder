// Generated by CoffeeScript 1.8.0
'use strict';
var $, cfg, cln_prefix, del, ff, gulp, order;

cfg = require('../config.json');

gulp = require('gulp');

$ = require('gulp-load-plugins')();

del = require('del');

ff = require('../index');

order = ['childs_need_to_be_deteled'];

cln_prefix = 'clean-';

order.forEach(function(the) {
  gulp.task(cln_prefix + the, function() {
    ff(the).forEach(function(_item, _index, _array) {
      del(_item + '/*');
    });
  });
});

gulp.task('clean', order.map(function(the) {
  return cln_prefix + the;
}));
