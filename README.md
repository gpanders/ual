# ual

`ual` is a tool to write and manage custom notes that can be viewed just like
man pages in your terminal, using the command `ual`. Your pages can be called
anything you like and can contain anything you like. This is useful for writing
down quick notes for complicated command invocations or other reference
material.

As an example, see some of my own notes
[here](https://github.com/gpanders/notes).

## Prerequisites

-   [`pandoc`](https://pandoc.org/)

## Installation

### macOS

```
brew install gpanders/tap/ual
```

### Other Platforms

```
curl -sLo /usr/local/bin/ual https://git.io/JerRw
```

## Usage

To view a note called `foo`, simply use

    ual foo

To create or modify the `foo` note, use

    ual edit foo

This will open the `foo` note in the editor set in the `$EDITOR` environment
variable, or simply `vi` if `$EDITOR` is unset.

You can list all notes with

    ual ls

You can delete the `foo` note using

    ual rm foo

Finally, if your notes directory is a git repository, you can synchronize your
notes with

    ual sync

`ual` will look for notes in `$UAL_PATH` or `$XDG_DATA_HOME/ual` if `$UAL_PATH`
is unset. `$XDG_DATA_HOME` resolves to `$HOME/.local/share` unless specifically
set otherwise.

## Writing Notes

Notes should be written in [Markdown format](https://pandoc.org/MANUAL.html#pandocs-markdown).
See below for an example.

````
# NAME

foo - A description of foo

# HEADING 1

Some notes about foo that I want to remember.

## SUBHEADING

This is **bold** text, this is _italic_ text, and this is `preformatted` text.

You can use definition lists to enumerate flags and options:

-f
: Force foo to do something

-r
: Make foo use the -r flag

Tables are also supported:

| Day       | Task  |
| ---       | ----  |
| Monday    | Clean |
| Wednesday | Sweep |


```
Use triple backticks to escape all formatting.
For example, **this text** will not be bold, and _this text_ will not be underlined.
This is useful for blocks of code or other preformatted text.
```
````
