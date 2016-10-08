#  ｈａｃｋｍｕｄ dev
Build system (using [GruntJS](http://gruntjs.com/)) for the game [hackmud](https://www.hackmud.com/), letting you write valid JavaScript so your linter will be happy, as well as performing basic minification (using [UglifyJS](https://github.com/mishoo/UglifyJS))

## Purpose
Minify scripts in a hackmud-friendly way (remove semi-colons, keep newlines, etc.) automatically as well as turning valid JavaScripts into hackmud-friendly scripts.

If you want your scripts to pass a linter you may use the constants `SCRIPTOR` and `DATABASE` instead of the hackmud macros `#s` and `#db`, these are replaced during the build process.

A few of the minifications it does;
* UglifyJS variable mangling
* Converts functions to ES6 arrow functions (experimental)
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

## Code
Original script (1,119 characters in hackmud)
`src/cowsay.js`
```
// Very basic cowsay script
function(context, args) { // say:message
    var msg = '';

    if (!args || Object.keys(args)[length] === 0) {
        args = {say:"mooo!\ni'm a cow"};
        msg = context.this_script + JSON.stringify(args) + newline;
    }

    var length = 'length',
        join = 'join',
        newline = "\n",
        space = " ",
        cow = [
            "        \\   ^__^",
            "         \\  (oo)\\_______",
            "            (__)\\       )\\/\\",
            "                ||----w |",
            "                ||     ||"
        ],
        balloon,
        maxLength = 0,
        lines = args.say.split(newline);

    // Pad short lines
    function pad(text, length) {
        return text + (new Array(length - text.length + 1))[join](space);
    }

    // Create top border of balloon
    function top(length) {
        return new Array(length + 3)[join]("_");
    }

    // Create bottom border of balloon
    function bottom(length) {
        return new Array(length + 3)[join]("-");
    }

    // Get length of the longest line
    for (var line = 0, len = lines[length]; line < len; line += 1) {
        if (lines[line][length] > maxLength) {
            maxLength = lines[line][length];
        }
    }

    // One-liners are output differently
    if (lines[length] === 1) {
        balloon = [
            space + top(maxLength),
            "< " + lines[0] + " >",
            space + bottom(maxLength)
        ];
    } else {
        balloon = [space + top(maxLength)];

        for (line = 0, len = lines[length]; line < len; line += 1) {
            var delimiter;

            if (line === 0) {
                delimiter = ["/","\\"];
            } else if (line === len - 1) {
                delimiter = ["\\","/"];
            } else {
                delimiter = ["|","|"];
            }

            balloon.push([delimiter[0],pad(lines[line], maxLength),delimiter[1]][join](space));
        }

        balloon.push(space + bottom(maxLength));
    }

    return msg + balloon[join](newline) + newline + cow[join](newline);
}
```

After processing (613 characters in hackmud)
`./cowsay.js`
```
function(a, b) {
    var c=(a, b)=>{        return a + new Array(b - a.length + 1)[i](k)}
    var d=(a)=>{        return new Array(a + 3)[i]("_")}
    var e=(a)=>{        return new Array(a + 3)[i]("-")}
    var f = ""
    b && 0 !== Object.keys(b)[h] || (b = {
        say: "mooo!\ni'm a cow"
    }, f = a.this_script + JSON.stringify(b) + j)
    for (var g, h = "length", i = "join", j = "\n", k = " ", l = [ "        \\   ^__^", "         \\  (oo)\\_______", "            (__)\\       )\\/\\", "                ||----w |", "                ||     ||" ], m = 0, n = b.say.split(j), o = 0, p = n[h]; o < p; o++) n[o][h] > m && (m = n[o][h])
    if (1 === n[h]) g = [ k + d(m), "< " + n[0] + " >", k + e(m) ]; else {
        for (g = [ k + d(m) ], o = 0, p = n[h]; o < p; o++) {
            var q
            q = !o ? [ "/", "\\" ] : o === p - 1 ? [ "\\", "/" ] : [ "|", "|" ], g.push([ q[0], c(n[o], m), q[1] ][i](k))
        }
        g.push(k + e(m))
    }
    return f + g[i](j) + j + l[i](j)
}
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
