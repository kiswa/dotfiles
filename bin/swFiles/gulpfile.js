var gulp = require('gulp'),
    del = require('del'),
    concat = require('gulp-concat'),
    filter = require('gulp-filter'),
    mainFiles = require('main-bower-files')(),

    scssLint = require('gulp-scss-lint'),
    sass = require('gulp-sass'),
    cssPrefixer = require('gulp-autoprefixer'),
    cssMinify = require('gulp-minify-css'),

    jsLint = require('gulp-jshint'),
    jsLintRep = require('jshint-stylish'),
    jsMinify = require('gulp-uglify'),

    src = 'src/',
    dist = 'dist/',
    paths = {
        js: src + 'js/*.js',
        scss: src + 'scss/*.scss',
        html: src + '*.html'
    };

gulp.task('clean', function() {
    return del(dist);
});

gulp.task('lint', function() {
    gulp.src(paths.js)
        .pipe(jsLint())
        .pipe(jsLint.reporter(jsLintRep));

    gulp.src(paths.scss)
        .pipe(scssLint({ 'config': 'lint.yml' }))
});

gulp.task('vendor', function() {
    if (!mainFiles.length) { return; }

    var jsFilter = filter('**/*.js'),
        cssFilter = filter('**/*.css');

    return gulp.src(mainFiles)
        .pipe(jsFilter)
        .pipe(concat('vendor.js'))
        .pipe(jsMinify())
        .pipe(gulp.dest(dist + 'lib/'))
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe(concat('vendor.css'))
        .pipe(cssMinify())
        .pipe(gulp.dest(dist + 'lib/'))
        .pipe(cssFilter.restore())
        .pipe(filter('**/fontawesome-webfont.*'))
        .pipe(gulp.dest(dist + 'fonts/'));
});

gulp.task('styles', function() {
    return gulp.src(paths.scss)
        .pipe(sass())
        .pipe(cssPrefixer())
        .pipe(concat('styles.css'))
        .pipe(cssMinify())
        .pipe(gulp.dest(dist + 'css/'));
});

gulp.task('scripts', function() {
    return gulp.src(paths.js)
        .pipe(concat('app.js'))
        .pipe(jsMinify())
        .pipe(gulp.dest(dist + 'js/'));
});

gulp.task('html', function() {
    return gulp.src(paths.html)
        .pipe(gulp.dest(dist));
});

gulp.task('watch', function() {
    var jsWatch = gulp.watch(paths.js, ['lint', 'scripts']),
        sassWatch = gulp.watch(paths.scss, ['lint', 'styles']),
        htmlWatch = gulp.watch(paths.html, ['html']);

    jsWatch.on('change', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    sassWatch.on('change', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
    htmlWatch.on('change', function(event) {
        console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
    });
});

gulp.task('default', ['clean', 'lint', 'vendor', 'styles', 'scripts', 'html']);
