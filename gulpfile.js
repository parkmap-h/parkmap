var gulp = require('gulp');

var browserSync = require('browser-sync');

var config = {
  dest: '_site'
};

// Static server
gulp.task('server', function() {
  gulp.watch('src/js/**/*.jsx', ['js']);
  gulp.watch('src/css/**/*.styl', ['css']);
  gulp.watch('src/html/**/*.jade', ['html']);
  browserSync({
    port: 8888,
    server: {
      baseDir: config.dest
    }
  });
});

var reload = browserSync.reload;

var react = require('gulp-react');
var browserify = require('gulp-browserify');
var plumber = require('gulp-plumber');

gulp.task('js', function() {
  gulp.src('src/js/main.jsx')
    .pipe(plumber())
    .pipe(react())
    .pipe(browserify({
        insertGlobals : true,
        debug : !gulp.env.production
      }))
    .pipe(gulp.dest(config.dest + '/js'))
    .pipe(reload({stream: true}));
});

var stylus = require('gulp-stylus');
gulp.task('css', function() {
  gulp.src('src/css/main.styl')
    .pipe(plumber())
    .pipe(stylus())
    .pipe(gulp.dest(config.dest + '/css'))
    .pipe(reload({stream: true}));
});

var jade = require('gulp-jade');
gulp.task('html', function() {
  gulp.src('src/html/*.jade')
    .pipe(plumber())
    .pipe(jade())
    .pipe(gulp.dest(config.dest))
    .pipe(reload({stream: true}));
});

gulp.task('default',['js','css','html','server']);
