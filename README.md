# ual

`ual` is a tool to write and manage custom notes that can be viewed just like
man pages in your terminal, using the command `ual`. Your pages can be called
anything you like and can contain anything you like. This is useful for writing
down quick notes for complicated command invocations or other reference
material.

As an example, see some of my own notes
[here](https://github.com/gpanders/notes).

## Prerequisites

-   [`scdoc`](https://drewdevault.com/2018/05/13/scdoc.html)

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

`ual` will look for notes in `$UAL_PATH` or `$HOME/.notes` if `$UAL_PATH` is
unset.

## Why scdoc?

[`scdoc`](https://drewdevault.com/2018/05/13/scdoc.html) is a lightweight tool
specifically designed for writing man pages. Like Markdown, the syntax is
plain-text readable and simple to write.

`scdoc` is available in many distribution repositories, and if it's not, it can
be simply downloaded [here](https://git.sr.ht/~sircmpwn/scdoc) and placed on
your PATH.

An example `scdoc` file can be found below.

````
foo(1)

# NAME

foo - A description of foo

# HEADING 1

Some notes about foo that I want to remember.

	Tabs should be used for indenting.

## SUBHEADING

This is *bold* text, and this is _underlined_ text.

*-f*
	Force foo to do something

*-r*
	Make foo use the -r flag


```
Use triple backticks to escape all scdoc formatting
For example, *this text* will not be bold, and _this text_ will not be underlined.
```
````
