# Base system install up through desktop
sudo pacman -Syu --needed base-devel git gum niri xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty networkmanager ghostty sddm plymouth swayidle swaylock docker docker-compose docker-buildx paru rustup lazygit jujutsu

# rustup setup/init
rustup default stable

# edit /etc/group and add your user to the docker group
# then do
sudo usermod -a -G docker $USER

paru -Sy matugen-git wl-clipboard cliphist cava qt6-multimedia-ffmpeg xwayland-satellite-git librewolf-bin
paru -Sy wlsunset python3 evolution-data-server pacsea-bin dropbox neofetch

paru -Sy quickshell gpu-screen-recorder brightnessctl ddcutil noctalia-shell polkit-kde-agent

mkdir -p ~/.config/quickshell/noctalia-shell
curl -sL https://github.com/noctalia-dev/noctalia-shell/releases/latest/download/noctalia-latest.tar.gz | tar -xz --strip-components=1 -C ~/.config/quickshell/noctalia-shell
cp -Rf config/noctalia ~/.config

sudo mkdir -p /etc/sddm.conf.d && sudo cp ./etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/autologin.conf

# Noctalia enable
mkdir -p ~/.config/systemd/user && cp ./config/systemd/user/noctalia.service ~/.config/systemd/user/noctalia.service

chmod +x ./bin/*sh
sudo ./bin/default-keyring.sh
sudo ./bin/sddm.sh

# plymouth boot splash
sudo cp -Rf ./usr/share/plymouth/themes/dual-power /usr/share/plymouth/themes/dual-power
sudo plymouth-set-default-theme dual-power
# add plymouth to dracut setup
sudo tee /etc/dracut.conf.d/myflags.conf <<EOF >/dev/null
add_dracutmodules+=" plymouth "
EOF

# setup nvim
git clone --depth=1 https://github.com/omacom-io/omarchy-pkgs
cd omarchy-pkgs/pkgbuilds/omarchy-nvim
makepkg -si
omarchy-nvim-setup
cd ../../../
rm -Rf omarchy-pkgs

# instlall onmybash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Install local config
cp -Rf ./config/* ~/.config/

# Install application desktop files
mkdir -p ~/.local/share
cp -Rf ./local/share/applications ~/.local/share

# let us enable some systemd services, both global and user
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable docker.service --now
systemctl --user enable noctalia.service

sudo reboot
