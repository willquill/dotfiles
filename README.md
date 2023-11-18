# dotfiles

My dot files

## About

The dot files go in `~/.zsh/`

The `~/.zsh` file sources `~/.zsh/*.zsh`

This way, all dot files are sourced.

## Usage

First clone the files from this repo into the `~/.zsh` directory. You don't need to `mkdir` first.

```sh
git clone git@github.com:willquill/dotfiles.git ~/.zsh
```

If Debian-based, run bootstrap script:

```sh
bash deb-bootstrap.sh
```

## Credit

- Inspiration from [Kevin](https://github.com/thatarchguy/dotfiles)
- 