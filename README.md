## Canta-gtk-theme

Canta is a flat Material Design theme for GTK 3, GTK 2 and Gnome-Shell which supports GTK 3 and GTK 2 based desktop environments like Gnome, Unity, Budgie, Pantheon, XFCE, Mate, etc.

This theme is based on materia gtk theme of nana-4. Thanks nana-4 sincerely for his great job!
#### materia gtk theme: https://github.com/nana-4/materia-theme

## Info

### GTK+ 3.20 or later

### GTK2 engines requirment
- GTK2 engine Murrine 0.98.1.1 or later.
- GTK2 pixbuf engine or the gtk(2)-engines package.

Fedora/RedHat distros:

    yum install gtk-murrine-engine gtk2-engines

Ubuntu/Mint/Debian distros:

    sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf

ArchLinux:

    pacman -S gtk-engine-murrine gtk-engines

Other:
Search for the engines in your distributions repository or install the engines from source.
## Install Or Uninstall

Open the terminal at current directory.

Run

    ./install.sh

### Install tips

Usage:  `./Install`  **[OPTIONS...]**

|  OPTIONS:           | |
|:--------------------|:-------------|
|-d, --dest           | Specify theme destination directory (Default: $HOME/.themes)|
|-n, --name           | Specify theme name (Default: Canta)|
|-c, --color          | Specify theme bright variant(s) **[standard/dark/light]** (Default: All variants)|
|-t, --theme          | Specify theme color variant(s) **[standard/blue/indigo]** (Default: All variants)|
|-s, --size           | Specify theme size variant **[standard/compact]** (Default: All variants)||
|-o, --ordinary       | Install theme without nautilus background image|
|-g, --gdm            | Install GDM theme|
|-i, --icon           | Install icon theme|
|-h, --help           | Show this help|

**FOR EXAMPLE**

    ./install.sh -c light -s compact -r square

Install light compact square version of Canta theme

    ./install.sh -d $HOME/.tmp -b

Install Canta theme with nautilus background image in $HOME/.tmp

## Install from Snap
<a href="https://snapcraft.io/canta-themes">
<img alt="Get it from the Snap Store" src="https://snapcraft.io/static/images/badges/en/snap-store-white.svg" />
</a>

You can install the theme from the Snap Store оr by running:

```
sudo snap install canta-themes
```
To connect the theme to an app run:
```
sudo snap connect [other snap]:gtk-3-themes canta-themes:gtk-3-themes
```
```
sudo snap connect [other snap]:icon-themes canta-themes:icon-themes
```

To connect the theme to all apps which have available plugs to gtk-common-themes you can run:

``` for i in $(snap connections | grep gtk-common-themes:gtk-3-themes | awk '{print $2}'); do sudo snap connect $i canta-themes:gtk-3-themes; done
```

``` for i in $(snap connections | grep gtk-common-themes:icon-themes | awk '{print $2}'); do sudo snap connect $i canta-themes:icon-themes; done
```

### Icon
#### Canta icon theme
Canta icon theme use numix-icon-theme-circle icon theme for Inherits,

so if you want a better experience you should install numix-circle first

#### numix-icon-theme-circle : https://github.com/numixproject/numix-icon-theme-circle

(Just install numix-circle nomal, Canta icon theme will use its icons resources for missing part!)

#### Install Canta theme with icon theme

    ./install.sh -i

### Kde theme
[Canta-kde](https://github.com/vinceliuice/Canta-kde)

## Screenshots
#### GNOME Shell
![1](https://github.com/vinceliuice/Canta-theme/blob/images/screenshots/screenshot1.png?raw=true)
![2](https://github.com/vinceliuice/Canta-theme/blob/images/screenshots/screenshot2.jpeg?raw=true)
![3](https://github.com/vinceliuice/Canta-theme/blob/images/screenshots/screenshot3.jpeg?raw=true)
![4](https://github.com/vinceliuice/Canta-theme/blob/images/screenshots/screenshot4.jpeg?raw=true)
![5](https://github.com/vinceliuice/Canta-theme/blob/images/screenshots/screenshot5.jpeg?raw=true)
