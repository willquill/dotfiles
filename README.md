# dotfiles

My dot files, managed by chezmoi

## Usage

Using on a new machine, after installing chezmoi (I use Ansible)

```sh
chezmoi init https://github.com/willquill/dotfiles.git
```

Check the diff to verify you aren't overwriting something you want to keep:

```sh
chezmoi diff
```

Apply the changes:

```sh
chezmoi apply
```

Pull latest changes from the repo and see what would change without applying:

```sh
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

## Modifying

On a system using chezmoi, if you want to edit the `~/.gitconfig` file, you should be editing the **template** instead of the file directly.

To edit `~/.local/share/chezmoi/dot_zshrc.tmpl`, use the following command:

```sh
chezmoi edit ~/.zshrc
```

This will open your editor to edit the template file that populates `~/.zshrc`.

Alternatively, enter the chezmoi directory with this:

```sh
chezmoi cd
```

### Ignore files/directories on different machines

See [here](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/#ignore-files-or-a-directory-on-different-machines) for documentation

```sh
vim ~/.local/share/chezmoi/chezmoiignore
```

Add these contents:

```go
README.md
{{- if ne .chezmoi.hostname "work-laptop" }}
.work # only manage .work on work-laptop
{{- end }}
```

This will omit installing the README on all machines and only install `.work` if hostname is `work-laptop`.

## Templating

To make managing chezmoi easier, the templates should, when possible, reference a chezmoi variable (similar to an Ansible fact), for which a key/value pair always exist on every host.

However, you can also have a template use a value that comes from a file on the host. For example, if I want the value of `init.templateDir` in my git config to be unique per host and for the value to *not* come from a chezmoi variable, I would need to populate the value within `~/.config/chezmoi/chezmoi.yaml` on the host. You can use TOML, JSON, JSONC, or YAML.

Here's an example of me creating and populating the file on a new macOS system:

```sh
mkdir -p ~/.config/chezmoi && echo -e "data:\n  templateDir: \"/Users/will/.git-template\"" > ~/.config/chezmoi/chezmoi.yaml
```

Alternatively, instead of manually creating the file, see [this doc](https://www.chezmoi.io/user-guide/setup/#re-create-your-config-file) on creating the config file automatically.

And in my `dot_gitconfig.tmpl` file, I would enter:

```toml
[init]
    templateDir = {{ .templateDir }} 
```

By doing that, the value of `templateDir` after applying my `dot_gitconfig.tmpl` file will be `/Users/will/.git-template`.

The `~/.zshrc` will also be generated from a template, but it uses chezmoi variables like `os` and `hostname` (see them with `chezmoi data`) and does not require the chezmoi.yaml file.

## Additional Notes

### Git Config

The `init.templateDir` specifies the directory from which template files and directories will be copied when initializing a new repository.

## Credit

- Inspiration from [Kevin](https://github.com/thatarchguy/dotfiles)
