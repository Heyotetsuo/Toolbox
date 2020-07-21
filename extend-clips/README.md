# Extend Clip
### Adds [n] seconds of pad to the end of a video clip

_Usage:_
./extendClip.sh \[source] [destination] \[inpoint (sec)] [duration (sec)]

_How it works:_
script loops from (inpoint) to (source)'s end for (duration) and outputs to (destination)

if duration is omitted, it defaults to 10

if inpoint is omitted, it defaults to 1

_Example:_
./extendClip.sh 'foo.mov' 'foo long.mov' 1.4 6;
