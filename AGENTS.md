# AGENTS.md

## Repository purpose
`bootstrap` bootstraps personal development machines with OS-specific install/setup scripts.

Current macOS setup includes:
- Homebrew packages/casks from `Brewfile`
- Shell and app dotfiles (`zsh`, `git`, `hammerspoon`, `psql`, `starship`)
- Language/runtime setup (`ruby` via `rbenv`, `dotnet`, `rust`)

Primary flow:
1. `install/<os>` clones this repo to `~/.bootstrap`
2. `setup/<os>` performs machine setup and copies config files into `$HOME`
3. Linux and Windows setup scripts are currently no-op stubs

## Important files
- `install/macos` — macOS entrypoint script for fresh machines
- `install/linux` — Linux entrypoint stub
- `install/windows.ps1` — Windows entrypoint stub
- `setup/macos` — main macOS provisioning script
- `setup/linux` — Linux setup stub
- `setup/windows.ps1` — Windows setup stub
- `Brewfile` / `Brewfile.lock.json` — macOS package definitions + lock
- `libexec/helpers` — shared shell helpers used by `setup/macos`
- `dotfiles/zshrc` — shell environment and PATH setup
- `dotfiles/gitconfig` — Git defaults
- `dotfiles/hammerspoon.lua` — Hammerspoon config
- `.config/starship.toml` — prompt config copied to `~/.config`
- `.psqlrc` — PostgreSQL shell config
- `scripts/brew-drift` — detect locally-installed brew packages not tracked in `Brewfile`
- `scripts/update` — local diff helper for selected dotfiles
- `.github/workflows/install.yml` — CI runs `setup/macos` on macOS

## Current install/path conventions
- User-level executable scripts are stored in `~/.local/bin` (XDG-style)
- `dotfiles/zshrc` prepends `~/.local/bin` to `PATH`
- Avoid introducing new `~/bin` paths unless explicitly required
- Prefer XDG base directory standards when practical:
  - config: `~/.config`
  - data: `~/.local/share`
  - state: `~/.local/state`
  - cache: `~/.cache`
  - executables: `~/.local/bin`

## Agent working guidelines
1. Keep changes minimal and targeted.
2. Prefer editing existing scripts over adding new tooling.
3. Preserve POSIX shell compatibility where scripts use `#!/bin/sh`.
4. Quote paths and variables in shell scripts (`"$HOME/..."`).
5. If changing install behavior, update both:
   - the relevant `setup/<os>` script
   - any corresponding shell PATH assumptions in `dotfiles/zshrc`
6. If package installation changes, update `Brewfile` (and lock file only if intentionally regenerated).
7. Do not commit secrets/tokens. (`dotfiles/zshrc` currently has placeholder-like env var entries; keep/redact carefully.)

## Common validation commands
Run from repo root:

```sh
# shell syntax check
sh -n setup/macos
sh -n setup/linux
sh -n install/macos
sh -n install/linux

# quick search for legacy bin path usage
rg -n "~/bin|\$HOME/bin"

# inspect brew drift helper behavior
ruby scripts/brew-drift
```

## Known caveats
- Install scripts clone via HTTPS by default. Use `BOOTSTRAP_REPO_URL` to override this for SSH/private clones.
- `setup/macos` uses macOS-oriented behavior (Homebrew prefix ownership, `Darwin` checks, MAS apps), so assume macOS unless explicitly refactoring.
- `setup/macos` copies files into `$HOME` (destructive overwrite behavior for some files like `~/.zshrc` and `~/.gitconfig`). Preserve this behavior unless asked to change it.
