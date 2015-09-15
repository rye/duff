# .emacs.d

## A note for Mac OS X users:

This configuration is usually used on a variety of systems, but the two tested variants are Linux-based and Darwin-based operating systems.
This Emacs installation has been tested on Mac OS X machines using the HEAD version of Emacs that can be installed via Homebrew, but there exists extra work to ensure that the dock-launchable version of Emacs is given the proper environment.

There is a function in `configuration-internals.el` that one can use as follows:

```emacslisp
(configuration-internals--mac-os-x-fixup-path (&optional force))
```

Another suggestion is to modify the Emacs.app file to make it use the command-line version of Emacs like so:

1. Create a new empty shell script in `/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/MacOS/` and mark it as executable with the same permissions as the other files in this directory (in this example, it is named `Emacs_via_shell.sh`).

2. Set the header/exec-line to `#!/bin/sh`, and change the first line to `echo '/usr/local/Cellar/emacs/HEAD/bin/emacs "$@"' | sh --login -s "$@"`.
This will run the command using the `~/.profile` file as the appropriate file, and, if we're using Duff's `~/.profile`, we should have the necessary environment information necessary to make informed decisions.

3. Edit the `Info.plist` file in the `/usr/local/Cellar/emacs/HEAD/Emacs.app/Contents/` directory and change the value of `CFBundleExecutable` to the name of your new shell script.

4. Remove the `-nw` flag from the command in `/usr/local/Cellar/emacs/HEAD/bin/emacs`.

Then, restart the Dock via `killall Dock`. It should now work better.  Please, report problems if you have any.
