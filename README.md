# 🍎 Niklas' minimal nix-darwin configuration

A minimal, reusable flake for macOS configurations using [`nix-darwin`](https://github.com/LnL7/nix-darwin) and [`home-manager`](https://github.com/nix-community/home-manager).

> ⚠️ This flake does **not** include any host-specific configuration — it's intended to be imported into other flakes.
> **Use with care**: Check the configuration before applying it to your system or use it as a inspiration for your own setup.

---

## 🧠 What It Provides

This flake is intended as a **clean base** for building your own `nix-darwin` system. It includes:

- `mkDarwinConfiguration`: a convenience function to construct a full `nix-darwin` system.
- `mkHomeConfiguration`: a function to create a home-manager configuration this is already executed in `mkDarwinConfiguration`.

What it configures:

- Uses **nix-darwin** to declaratively manage macOS configuration.

- Manages:

  - **CLI tools** via Nix
  - **GUI apps** mostly via Homebrew Casks

- Configures **Zsh** using [`home-manager`](https://github.com/nix-community/home-manager).
- Keeps application config (e.g. Neovim, tmux) **out of this repo** — see [my dotfiles repo](https://github.com/niklas-scholz/dotfiles) for that.

---

## 🚀 Getting Started

### 1. Install Nix

Follow the [official instructions](https://nixos.org/download.html).

### 2. Install nix-darwin

Follow the [nix-darwin installation instructions](https://github.com/nix-darwin/nix-darwin?tab=readme-ov-file#getting-started)

### 3. Create a new flake like in the following example:

```nix
{
  description = "Nix-darwin configuration for Nik's MacBook-Pro";

  inputs = {
    darwin-minimal.url = "github:niklas-scholz/flakes";
  };

  outputs =
    inputs@{
      self,
      darwin-minimal,
    }:
    let
      username = "niklasscholz";

      extraModules = [
        ./hosts/private.nix
      ];
    in
    {
      darwinConfigurations."MacBook-Pro" = darwin-minimal.mkDarwinConfiguration {
        inherit username extraModules;
        extraHomeManagerConfiguration = {
          programs.zsh.sessionVariables = {
            FOO = "bar";
          };
        };
      };
    };
}
```

### 3. Apply the configuration

```bash
sudo darwin-rebuild switch --flake .
```
