# vim-ftdetect

A command-line utility that uses Vim's filetype detection mechanism to
determine the filetype of a file.

## Usage

```sh
vim-ftdetect <file>
```

The script will output the detected filetype for the given file. If no filetype
is detected or in case of error, it will exit with a non-zero status.

It tries to set up a clean Vim environment, but adds the user's user's `.vim`
directory to the runtime path. Be sure that you understand the security
implications of this.
