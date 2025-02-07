# Install Dependencies
sudo apt install xorg lightdm lightdm-gtk-greeter \
		i3-wm i3lock i3status i3blocks dmenu \
		terminator lxappearance fonts-font-awesome fonts-hack-ttf

# Activate Desktop Manager
sudo systemctl enable lightdm.service
sudo systemctl start lightdm.service
