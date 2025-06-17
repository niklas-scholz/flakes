# 🍎 Niklas' nix-darwin Flakes

This repository contains my [nix-darwin](https://github.com/nix-darwin/nix-darwin) configuration using Nix flakes. It defines setups for two macOS hosts — my **work** and **private** laptops — and is intended as a solid starting point for anyone looking to configure macOS declaratively with Nix.

> ⚠️ Still under construction — but usable as a starter template.

---

## 🧠 What This Repo Does

- Uses **nix-darwin** to declaratively manage macOS configuration.
- Defines separate setups for:

  - `private`: My personal laptop
  - `work`: My work-issued machine

- Both hosts inherit from a shared base configuration, which defines common packages, settings, and module imports.

- Manages:

  - **CLI tools** via Nix
  - **GUI apps** mostly via Homebrew Casks

- Configures **Zsh** using [`home-manager`](https://github.com/nix-community/home-manager).
- Keeps application config (e.g. Neovim, tmux) **out of this repo** — see [my dotfiles repo](https://github.com/niklas-scholz/dotfiles) for that.

---

## 🚀 Getting Started

### 1. Install Nix (multi-user)

Follow the [official instructions](https://nixos.org/download.html).

### 2. Clone this repo

```sh
git clone https://github.com/niklas-scholz/flakes.git
cd flakes
```

### 3. Run `darwin-rebuild`

If the current machine's host name matches one of the defined hosts in [flake.nix](./flake.nix), you can simply run:

```sh
sudo darwin-rebuild switch --flake .
```

For a specific host configuration:

```sh
sudo darwin-rebuild switch --flake .#MacBook-Pro
```

## 🚧 Future Plans

I'm working on extracting a reusable module so this configuration can be imported into private or external Darwin setups. This will allow me to:

- Maintain a private repo for work machines
- Reuse shared config (e.g. Zsh, package sets) across systems
- Keep sensitive configs out of public view
