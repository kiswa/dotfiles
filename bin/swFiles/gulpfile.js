var gulp = require('gulp'),
    del = require('del'),
    concat = require('gulp-concat'),
    filter = require('gulp-filter'),
    mainFiles = require('main-bower-files')(),

    scssLint = require('gulp-scss-lint'),
    sass = require('gulp-ruby-sass'),
    cssPrefixer = require('gulp-autoprefixer'),
    cssMinify = require('gulp-minify-css'),

    jsLint = require('gulp-jshint'),
    jsLintRep = require('jshint-stylish'),
    jsMinify = require('gulp-uglify'),

    src = 'src/',
    dist = 'dist/',
    bootstrap = 'bower_components/bootstrap-sass-official/assets/stylesheets',
    paths = {
        js: src + 'js/**/*.js',
        scss: src + 'scss/**/*.scss',
        images: src + 'images/**/*',
        html: src + '**/*.html'
    };

gulp.task('clean', function() {
    del(dist);
});

gulp.task('lint', ['lintJs', 'lintScss']);

gulp.task('lintJs', function() {
    return gulp.src(paths.js)
        .pipe(jsLint())
        .pipe(jsLint.reporter(jsLintRep));
});

gulp.task('lintScss', function() {
    return gulp.src(paths.scss)
        .pipe(scssLint({ config: 'lint.yml' }));
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
        .pipe(sass({
            loadPath: [
                src + 'scss',
                bootstrap
            ]
        }))
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

gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(gulp.dest(dist + 'images/'));
});

gulp.task('watch', function() {
    var watchJs = gulp.watch(paths.js, ['lintJs', 'scripts']),
        watchScss = gulp.watch(paths.scss, ['lintScss', 'styles']),
        watchHtml = gulp.watch(paths.html, ['html']),

        onChanged = function(event) {
            console.log('File ' + event.path + ' was ' + event.type + '. Running tasks...');
        };

    watchJs.on('change', onChanged);
    watchScss.on('change', onChanged);
    watchHtml.on('change', onChanged);
});

gulp.task('default', ['clean', 'lint', 'vendor', 'styles', 'scripts', 'html', 'images']);
