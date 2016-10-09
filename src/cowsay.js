// Very basic cowsay script
(function(context, args) { // say:message
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
}());