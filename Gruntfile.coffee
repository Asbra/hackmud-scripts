module.exports = (grunt) ->
    grunt.loadNpmTasks('grunt-contrib-clean')
    grunt.loadNpmTasks('grunt-contrib-copy')
    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        clean: ['build/*.js', '*.js']
        copy:
            pre:
                src: ['src/*.js']
                dest: 'build/'
                flatten: true
                expand: true
                options: {
                    process: (content, srcpath) ->
                        return content
                                # Replace hackmud macros
                                .replace(/#s/g, 'SCRIPTOR')
                                .replace(/#db/g, 'DATABASE')
                                # Remove comments
                                .replace(/\s*\/\/[^\n]*/, '')
                                .replace(/\/\*[^*]*\*+([^\/][^*]*\*+)*\//, '')
                                # Remove lines
                                .replace(/\r/gm, '')
                                .replace(/\n+/gm, "\n")
                                # Add JavaScript-friendly wrapper
                                .replace(/^[^f].*f/, 'f')
                                .replace(/function/, '(function')
                                .replace(/\}$/, '}());')
                }
            post:
                src: ['build/*.js']
                dest: './'
                flatten: true
                expand: true
                options: {
                    process: (content, srcpath) ->
                        return content
                                # Fix hackmud macros
                                .replace(/SCRIPTOR/g, '#s')
                                .replace(/DATABASE/g, '#db')
                                # Removes JavaScript wrapper
                                .replace(/^[!\(]function/, 'function')
                                .replace(/\}\(\)\)?;$/m, '}')
                                # Removes semicolons
                                .replace(/;$/gm, "")
                                # Replaces comparisons with 0
                                .replace(/(\w+)\s?===?\s?0/gm, '!$1')
                                .replace(/0\s?===?\s?(\w+)/gm, '!$1')
                                # Replaces += 1 with ++
                                .replace(/(\w+)\s?\+=\s?1([^\d])/g, '$1++$2')
                                # Replaces -= 1 with --
                                .replace(/(\w+)\s?-=\s?1([^\d])/g, '$1--$2')
                                # Converts functions to ES6 arrow functions
                                # .replace(/function\s*(\w)\s*\(([^\)]+)\)\s*\{\n?(?:[^\}\n\w]*)\s+return\s+([^\}\n]+)[\n\}\s]+\}/g, 'var $1=($2)=>$3')
                                .replace(/function\s*(\w)\s*\(([^\)]+)\)\s*\{\n?([^\}]*)\s+return\s+([^\}\n]+)[\n\}\s]+\}/g, 'var $1=($2)=>{$3 return $4}')
                }
        uglify:
            options:
                mangle: true
                # compress: false
                beautify: true
            build:
                files: [{
                    expand: true,
                    cwd: 'build',
                    src: '**/*.js',
                    dest: 'build'
                }]
    grunt.registerTask('default', ['clean', 'copy:pre', 'uglify', 'copy:post'])