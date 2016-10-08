#  ｈａｃｋｍｕｄ dev
Build system (using [GruntJS](http://gruntjs.com/)) for the game [hackmud](https://www.hackmud.com/), letting you write valid JavaScript so your linter will be happy, as well as performing basic minification (using [UglifyJS](https://github.com/mishoo/UglifyJS))

## Purpose
Minify scripts in a hackmud-friendly way (remove semi-colons, keep newlines, etc.) automatically as well as turning valid JavaScripts into hackmud-friendly scripts.
If you want your scripts to pass a linter you may use the constants `SCRIPTOR` and `DATABASE` instead of the hackmud macros `#s` and `#db`, these are replaced during the build process.

A few of the minifications it does;
* UglifyJS variable mangling
* Converts one-statement functions to ES6 arrow functions
* Replaces -=/+= 1 with --/++
* Replaces === 0 with !
* Removes semicolons

## Future
Support for ES6 techniques. (waiting on UglifyJS)
Add more automated minification techniques specific to hackmud pre-processor.

## Installation
1. Place in your hackmud user scripts directory, eg. `%APPDATA%\username\scripts\` on Windows.
2. Run `npm install` in the folder
3. **Move your .js files to `src/`**

### Important
Don't keep your scripts in the `scripts` folder, **they will get deleted!**

## Examples
Original script (1,813 characters in hackmud)
`src/cowsay.js`
```

```

After processing (756 characters in hackmud)
`./cowsay.js`
```

```

## Usage
Place your scripts in `src/`
Run `grunt`
Upload script in hackmud `#up script`

## hackmud golfing tips
hackmuds' pre-processor ignores whitespaces
hackmud uses ES6 (however UglifyJS does not)

*Resources for JavaScript golfing techniques*
- [Tips for golfing in JavaScript](http://codegolf.stackexchange.com/questions/2682/#answers)
- [Tips for golfing in ES6](http://codegolf.stackexchange.com/questions/37624/#answers)
