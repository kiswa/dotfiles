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

    imageMin = require('gulp-imagemin'),

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
        .pipe(gulp.dest(dist + 'lib/'))
        .pipe(jsFilter.restore())
        .pipe(cssFilter)
        .pipe(concat('vendor.css'))
        .pipe(gulp.dest(dist + 'lib/'))
        .pipe(cssFilter.restore())
        .pipe(filter('**/fontawesome-webfont.*'))
        .pipe(gulp.dest(dist + 'fonts/'));
});

gulp.task('minify', function() {
    // Minify vendor.js and vendor.css
    gulp.src(dist + 'lib/vendor.css')
        .pipe(cssMinify())
        .pipe(gulp.dest(dist + 'lib/'));
    gulp.src(dist + 'lib/vendor.js')
        .pipe(jsMinify({ preserveComments: 'some'}))
        .pipe(gulp.dest(dist + 'lib/'));

    // Minify project styles and scripts
    gulp.src(dist + 'css/styles.css')
        .pipe(cssMinify())
        .pipe(gulp.dest(dist + 'css/'));
    gulp.src(dist + 'js/app.js')
        .pipe(jsMinify({ preserveComments: 'some'}))
        .pipe(gulp.dest(dist + 'js/'));
});

gulp.task('styles', function() {
    return gulp.src(paths.scss)
        .pipe(sass())
        .pipe(cssPrefixer())
        .pipe(concat('styles.css'))
        .pipe(gulp.dest(dist + 'css/'));
});

gulp.task('scripts', function() {
    return gulp.src(paths.js)
        .pipe(concat('app.js'))
        .pipe(gulp.dest(dist + 'js/'));
});

gulp.task('html', function() {
    return gulp.src(paths.html)
        .pipe(gulp.dest(dist));
});

gulp.task('images', function() {
    return gulp.src(paths.images)
        .pipe(imageMin())
        .pipe(gulp.dest(dist + 'images/'));
});

gulp.task('watch', function() {
    var watchJs = gulp.watch(paths.js, ['lintJs', 'scripts']),
        watchScss = gulp.watch(paths.scss, ['lintScss', 'styles']),
        watchHtml = gulp.watch(paths.html, ['html']),
        watchImages = gulp.watch(paths.images, ['images']),

        onChanged = function(event) {
            console.log('File ' + event.path + ' was ' + event.type + '. Running tasks...');
        };

    watchJs.on('change', onChanged);
    watchScss.on('change', onChanged);
    watchHtml.on('change', onChanged);
    watchImages.on('change', onChanged);
});

gulp.task('default', ['clean', 'lint', 'vendor', 'styles', 'scripts', 'html', 'images']);
