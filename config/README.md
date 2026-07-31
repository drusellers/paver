# Config layout

Home-directory config is layered by operating-system compatibility:

1. `config/shared/home` — config that should apply everywhere.
2. `config/unix/home` — config shared by macOS and Linux.
3. `config/<os>/home` — OS-specific overrides and app config (`macos`, `linux`, `windows`).

macOS and Linux setup scripts copy each applicable `home` tree into `$HOME` in that order, so later layers can override earlier layers.

Current placement:

- `shared/home/.gitconfig` — Git defaults shared across OSes.
- `shared/home/.config/starship.toml` — Starship prompt config.
- `unix/home/.ssh/config` — SSH config for macOS and Linux, including the generated `~/.ssh/github` identity for GitHub hosts.
- `unix/home/.psqlrc` — psql config for macOS and Linux.
- `macos/home/.zshrc` — current zsh environment, with macOS/Homebrew assumptions.
- `macos/home/.hammerspoon/init.lua` — Hammerspoon config.
