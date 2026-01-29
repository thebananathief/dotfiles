# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Source of truth / docs
- `README.md` (WSL Arch bootstrap notes)
- Windows bootstrap + symlink entrypoint: `setup.ps1`
- Windows “install lots of apps + symlinks” entrypoint: `programs.ps1`
- Linux/WSL Zsh bootstrap entrypoint: `setup.sh`

## Common commands
### Windows (PowerShell)
Run from the repo root so `$PWD`-derived paths in the scripts are correct.
- Bootstrap (installs terminal tooling + creates symlinks; UAC prompt expected for symlinks):
  - `pwsh -NoProfile -ExecutionPolicy Bypass -File .\setup.ps1`
- Install additional programs + apply Windows integrations (see script for details; UAC prompt expected):
  - `pwsh -NoProfile -ExecutionPolicy Bypass -File .\programs.ps1`

### Linux / WSL
- Zsh plugins + config linking (see script for prerequisites/behavior):
  - `chmod +x ./setup.sh`
  - `./setup.sh`

## High-level structure (big picture)
This repo is a “source of truth” for personal configuration files plus a couple of OS-specific bootstrap scripts.

- Windows automation and linking:
  - `setup.ps1` and `programs.ps1` install tools (via winget/Scoop/etc) and create/refresh symlinks from standard Windows locations back into this repo.
  - Windows Terminal configuration lives in `WindowsTerminal/settings.json`.
  - PowerShell profile lives in `Microsoft.PowerShell_profile.ps1`.
  - AutoHotkey startup script is `Passive.ahk`.
  - Nilesoft Shell customizations are under `Nilesoft Shell/` (see `Nilesoft Shell/custom.nss`).

- Cross-platform shell config:
  - Zsh: `.zshrc` plus shared aliases in `.shell_aliases` (linked by `setup.sh` into oh-my-zsh custom config).
  - Bash: `.bashrc`.

- App configs:
  - Starship prompt config: `.config/starship.toml`.
  - Neovim config: `.config/nvim/` (Lua modules under `.config/nvim/lua/`).

## Notes for agents working here
- If you need the exact list of symlinks, install steps, or prerequisites, read the entrypoint scripts directly (`setup.ps1`, `programs.ps1`, `setup.sh`) rather than duplicating them here.
- Generated/editor state is ignored (see `.gitignore`, e.g. Neovim `lazy-lock.json` and `/shada`).
