<p align="center">
  <img src="logo.png" alt="Dual Power logo" />
</p>

> ⚠️ The Dual Power project is in a PRE-ALPHA state; It provides zero guarantee
> of stability or correctness. You have been warned.

Dual Power is an out-of-the-box setup for Arch/EndevourOS Linux. It is meant to
be deployed over a fresh install of the Linux distro. It's
original inspiration was liberated from the [O****** project][2].
Like O******, Dual Power is developer focused. It uses a different
collection of software to make up it's base, although it borrows
a few components (like its LazyVim setup, screensaver scheme, etc).

This project is yet another meta-distro, "pre-riced for a certain setup", but without
a focus on built-in configurability for the defaults. So, if your immediate
reaction to any of the software, aesthetic, configuration, etc choices is negative,
then we do apologize. Dual Power may not be the one for you.
Configurable defaults for desktop, term, shell/bar/finder, DE, etc aren't a priority.
You can install/configure/integrate those yourself. Otherwise, please have Fun!

The name _Dual Power_ derives from a [historical power-sharing arrangement][9] that
arose in in Russia, circa 1917. Governance was jointly exercised by both the
Provisional Government and Petrograd Soviet, after the abdication of Tsar Nicholas
and the resulting February Revolution. The name is [lampshading][10] the overlapping
and unclear boundaries between the underlying distribution (Arch/EndevourOS) and
the Dual Power meta-distro itself. Dual Power maintains no self-hosted package/AUR
repositories and is purely parasitic on the underlying Arch/EndevousOS Linux distributions.

Insofar as this project has liberated several script assets from O******, it is
released under the terms of the MIT License. See `LICENSE` for details.

## Install playbook

Currently this is a manual install process, outlined below.

Start with installing vanilla Arch Linux or EndevourOS (with no desktop).

### Pre-Install: EndevourOS

Follow [this guide][1] for limine/snapper setup on a fresh EndevousOS install.
Be sure to select `btrfs` and drive encryption. Choose "No Desktop" install option.
This guide probably (mostly, untested) works for vanilla Arch as well.

At one point in the guide you will delete the `/.snapshots` directory.
When completing the guide, you will install `snap-pac`; This step will fail
without that folder.

Run `sudo mkdir /.snapshots` and then `pacman -S snap-pac` again and it should
complete without error.

### Dual Power Install

1. Run the `./install.sh` script
1. edit `/etc/kernel/cmdline` and append "quiet splash" to the end
1. It is recommended to install a non-vanilla kernel; We like `linux-lqx`
    - edit `/etc/makepkg.conf`, find the `MAKEFLAGS` variable and change it to `MAKEFLAGS="-j$(nproc)"`
    - `sudo pacman -Syu linux-lqx`

## What Dual Power Is

### Behavior/Workflow

- As in O******, Dual Power relies upon disk encryption + autologin via `sddm`
for security
- noctalia-shell provides most of the "desktop" experience; it can be customized
to your liking; is not particularly keyboard-driven
- We rely upon `pacsea` for package management/updates; no auto-update runner is
provided, but `pacsea` has everything you need; It has a provided `.desktop`
shortcut and can be launched/ran directly without opening a terminal

### The Software Suite

- Wayland, [Niri][5], and [noctalia-shell][4] make up the core user experience
  - Niri keybinds are slightly customized from Niri defaults and integrate with
    noctalia-shell actions; show keybinds with `Mod+Shift+/`
  - A `gruvbox` style theme is used, but swapping out the yellows/greens for reds
    & blues, yellow/green kept in places; the default `grubbox` themes are used
    elsewhere
  - `xwayland-satellite-git` from AUR is installed by default and Niri knows how
    to use it, so X programs should Just Work
- [alacritty][1] is the default terminal
- [Kanshi][3] is installed and running via Niri
  - It is inert by default; you will need to provide your own `~/.config/kanshi/config`
    based on your monitor setup(s)
- [NeoVim][6] & [LazyVim][7]
  - Has some additional tweaks for the author's preferred workflow
  - Rainbow brackets
  - lazygit nvim integration
  - autosave upon exiting insert mode, window/buffer change, etc
- [LibreWolf][8] is the default web browser (Shortcut: `Mod+Shift+B`)
  - FIXME Add LibreWolf config/profiles into install
  - It is configured, when launched, to start the Profile Manager dialog
  - Two profiles are installed and configured by default: `persistent` & `scratch`
  - `persistent` is a profile that preserves cookies, history, etc across browser restarts; All previous tabs are restored upon startup
  - `scratch` does not preserve cookies, history, etc across browser restarts; All previous tabs are restored upon startup

### Post-Install concerns

#### GPU/Graphics

- If you have an AMD GPU, you will want to look into installing your drivers: `vulkan-radeon`, etc; probably should install Steam or w/e as well to test that it's working

[1]: https://forum.endeavouros.com/t/guide-how-to-install-and-configure-endeavouros-for-bootable-btrfs-snapshots-using-limine-and-limine-snapper-sync/69742
[2]: https://github.com/basecamp/Omarchy
[3]: https://wiki.archlinux.org/title/Kanshi
[4]: https://docs.noctalia.dev/docs/
[5]: https://yalter.github.io/niri/
[6]: https://neovim.io/
[7]: https://www.lazyvim.org/
[8]: https://librewolf.net/
[9]: https://en.wikipedia.org/wiki/Dual_power
[10]: https://tvtropes.org/pmwiki/pmwiki.php/Main/LampshadeHanging
