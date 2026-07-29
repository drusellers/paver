# Bootstrap

Personal machine bootstrap scripts for macOS, Linux, and Windows.

## Layout

- `install/macos` clones this repository into `~/.bootstrap` and runs `setup/macos`.
- `install/linux` clones this repository into `~/.bootstrap` and runs the Linux setup stub.
- `install/windows.ps1` clones this repository into `~/.bootstrap` and runs the Windows setup stub.
- `setup/macos` contains the current macOS provisioning flow.
- `setup/linux` and `setup/windows.ps1` are placeholders for future work.

Set `BOOTSTRAP_DIR` or `BOOTSTRAP_REPO_URL` to override the default clone location or repository URL.

## macOS

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/macos)"
```

## Linux

Linux support is currently stubbed out.

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/linux)"
```

## Windows

Windows support is currently stubbed out.

```powershell
Invoke-RestMethod https://raw.githubusercontent.com/drusellers/bootstrap/HEAD/install/windows.ps1 | Invoke-Expression
```
