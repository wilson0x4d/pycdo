# `pycdo` is a pycfile deobfuscation tool.

Copyright (c) 2024 Shaun Wilson, see `LICENSE` file for full license details.

## Why?

I wanted something light on the CPU, cross-platform, container-friendly, and easy to automate (permuations) from my other tools. It was for me. I'm sharing with you. Take it or leave it.

## Installation

There is no packaged library, and there is no installer.

After fetching the git repo you can symlink the main script file into `$PATH` somewhere, like `/usr/local/bin`.

The only non-standard dependency is [`watchdog`](https://pypi.org/project/watchdog/), but the tool should still work correctly without this dependency installed.

I use [`poetry`](https://pypi.org/project/poetry/) for dependency management, and `venv` to create an environment. Under the `sys/` directory you can find two scripts to help create and activate the virtual env (if you need to):

```bash
#
# pull the repo and prep the environment
#
git clone https://github.com/wilson0x4d/pycdo.git
cd pycdo
sys/init-venv.sh
sys/with-venv.sh
ln -s "$PWD/src/pycdo" "/usr/bin/pycdo"
#
# now you can run it from anywhere within the context of the virtual env you've configured.
#
pycdo --help
```

## Usage

Running `pycdo` requires a "pycrules" file, an example file can be found in the repo at `src/default.pycrules`.

```bash
# test using a non-obfuscated pycfile
pycdo input.pyc output.pyc --rules default.pycrules
```

```bash
# test using an obfuscated pycfile
pycdo obfuscated.pyc deobfuscated.pyc --rules custom.pycrules
```

### What are "pycrules" ?

The "pycrules" file is a simple python source file that exposes a series of functions that `pycdo` uses during deobfuscation. It is the product of my own deobfuscation needs and while some of it is self-explanatory, some of it is not. I've tried to add useful comments to the `default.pycrules` file, but YMMV. My advice is to start with the `default.pycrules` as a baseline and take a dive into the source code if you need to understand how something works. Most people will only need `inprocess()` and `get_opcode_remap()` customizations.

When the `--rules` argument is omitted `pycdo` will attempt to load `default.pycrules` from the current working directory. 

> NOTE: Like all code you receive.. do not use a pycrules file received from someone else without first reviewing the contents.

### Watchdog?

Oh. Yes, please.

When reversing obfuscated code it's helpful to have `pycdo` re-apply the pycrules to the obfuscated input whenever the pycrules are updated.

That is what the `--watch` option does. 

It has a single required parameter for a program or script to be run after the pycrules are re-applied. If you don't need to run any command and just want the regeneration feature then pass in a script that doesn't do anything.

I find it helpful to start `pycdo` in a terminal off to the side while I am reversing, I'll use the `--watch` option to configure `pycdo` to run a decompiler after every pycrules file change. I'll also pass a `--debug 1` option to get a little more feedback from `pycdo`:

```bash
pycdo --force /data/input.pyc /data/output.pyc --rules /data/wip.pycrules --debug 1 --watch "/data/run-decompiler.sh"
```

When done just break (Ctrl+C) to exit watch mode.

## Contributing

As with most of my projects the github repo is just a public mirror.

If you want to contribute open an Issue on Github with a link to a fork containing your changes, then ping me on Discord to let me know. I usually respond within a day, if everything looks good I'll work with you to get it merged.
