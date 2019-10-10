# ual

`ual` is a tool to write and manage custom notes that can be viewed just like
man pages in your terminal, using the command `ual`. Your pages can be called
anything you like and can contain anything you like. This is useful for writing
down quick notes for complicated command invocations or other reference
material.

As an example, see some of my own notes
[here](https://github.com/gpanders/notes).

## Prerequisites

[`pandoc`](https://pandoc.org/installing.html) and
[`groff`](https://www.gnu.org/software/groff/) are required to convert Markdown
documents into `man` page format.

`groff` comes pre-installed on most Unix systems. Both are available on almost
all package managers.

## Installation

### fish

Set the variables `ual_path` and `ual_author` in your `config.fish` file (the
defaults are `$HOME/.notes` and empty, respectively).

#### Fisher

    fisher add gpanders/ual

-------------------------------------------------------------------------------

### zsh

Set the variables `UAL_HOME` and `UAL_AUTHOR` in your `.zshrc` (the defaults
are `$HOME/.notes` and empty, respectively).

#### Antigen

    antigen bundle gpanders/ual

#### Oh My Zsh

1.  Clone this repository into `~/.oh-my-zsh/custom/plugins`

        git clone https://github.com/gpanders/ual ~/.oh-my-zsh/custom/plugins/ual

2.  Add the plugin to the list of plugins for Oh My Zsh to load (inside
    `~/.zshrc`)

        plugins=(ual)

-------------------------------------------------------------------------------

## Usage

To view a note called `foo`, simply use

    ual foo

To create or modify the `foo` note, use

    ual edit foo

You can list all notes with

    ual ls

You can delete the `foo` note using

    ual rm foo

Finally, if your notes directory is a git repository, you can synchronize your
notes with

    ual sync

## Writing Notes

There is no requirement on how you write your notes; however, in order to make
your notes look as much like a real man page as possible, you can use the
following template:

``` {.markdown}
# NAME

foo - A description of foo

# HEADING 1

Some notes about foo that I want to remember.

You can use Markdown definition lists for things like option flags:

-f
:  Force foo to do something

-r
:  Make foo use the -r flag

## Subheading

Subheadings are indented one level in the final man page output. The case of
the headings (lower, upper, or mixed) does not matter.

# REFERENCES

-  <http://www.foo.com/a-page-describing-foo>
```
