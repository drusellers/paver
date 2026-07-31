# Bootstrap

Personal machine bootstrap scripts for macOS, Linux, and Windows.

## Layout

- `install/macos` clones this repository into `~/.bootstrap` and runs `setup/macos`.
- `install/linux` clones this repository into `~/.bootstrap` and runs `setup/linux`.
- `install/windows.ps1` clones this repository into `~/.bootstrap` and runs the Windows setup stub.
- `setup/macos` contains the current macOS provisioning flow.
- `setup/linux` applies shared/Unix-compatible config; package/runtime setup is still stubbed.
- `setup/windows.ps1` is a placeholder for future work.
- `config/shared`, `config/unix`, and `config/<os>` contain layered home-directory config.
- `libexec/ensure-github-ssh-key` creates the GitHub SSH key expected by SSH config.

Set `BOOTSTRAP_DIR` or `BOOTSTRAP_REPO_URL` to override the default clone location or repository URL.

## SSH / GitHub

macOS and Linux setup call `libexec/ensure-github-ssh-key` to generate an Ed25519 GitHub key at `~/.ssh/github` when it is missing, with the public key at `~/.ssh/github.pub`. You can also run that script directly. Interactive runs prompt for a passphrase; add the public key to GitHub after setup.

## macOS

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/macos)"
```

## Linux

Linux package/runtime setup is currently stubbed out, but shared and Unix-compatible config is applied.

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/linux)"
```

## Windows

Windows support is currently stubbed out.

```powershell
Invoke-RestMethod https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/windows.ps1 | Invoke-Expression
```
