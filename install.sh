#!/bin/bash
#set -ueo pipefail
#set -x

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/themes"
  ICON_DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.themes"
  ICON_DEST_DIR="$HOME/.icons"
fi

SRC_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Canta
COLOR_VARIANTS=('' '-dark' '-light')
SIZE_VARIANTS=('' '-compact')
RADIUS_VARIANTS=('' '-square')

show_info() {
  echo -e "\033[1;34m$@\033[0m"
}

show_tips() {
  echo -e "\033[1;32m$@\033[0m"
}

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-c, --color VARIANTS..." "Specify theme color variant(s) [standard|dark|light] (Default: All variants)"
  printf "  %-25s%s\n" "-s, --size VARIANT" "Specify theme size variant [standard|compact] (Default: All variants)"
  printf "  %-25s%s\n" "-r, --radius VARIANT" "Specify theme radius variant [standard|square] (Default: All variants)"
  printf "  %-25s%s\n" "-g, --gdm" "Install GDM theme"
  printf "  %-25s%s\n" "-i, --icon" "Install icon theme"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
  printf "\n%s\n" "INSTALLATION EXAMPLES:"
  printf "%s\n" "Install all theme variants into ~/themes"
  printf "  %s\n" "$0 --dest ~/themes"
  printf "%s\n" "Install all theme variants into ~/themes including GDM theme"
  printf "  %s\n" "$0 --dest ~/themes --gdm"
  printf "%s\n" "Install standard theme variant only"
  printf "  %s\n" "$0 --dest ~/icons --icon"
  printf "%s\n" "Install standard icon theme only"
  printf "  %s\n" "$0 --color standard --size standard"
  printf "%s\n" "Install square theme variant only"
  printf "  %s\n" "$0 --color standard --size standard --radius square"
  printf "%s\n" "Install specific theme variants with different name into ~/themes"
  printf "  %s\n" "$0 --dest ~/themes --name MyTheme --color light dark --size compact"
}

install() {
  local dest=${1}
  local name=${2}
  local color=${3}
  local size=${4}
  local radius=${5}

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}

  local THEME_DIR=${dest}/${name}${color}${size}${radius}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  mkdir -p                                                                           ${THEME_DIR}
  cp -ur ${SRC_DIR}/COPYING                                                          ${THEME_DIR}
  cp -ur ${SRC_DIR}/AUTHORS                                                          ${THEME_DIR}

  echo "[Desktop Entry]" >> ${THEME_DIR}/index.theme
  echo "Type=X-GNOME-Metatheme" >> ${THEME_DIR}/index.theme
  echo "Name=Canta${color}${size}${radius}" >> ${THEME_DIR}/index.theme
  echo "Comment=An Flat Gtk+ theme based on Material Design" >> ${THEME_DIR}/index.theme
  echo "Encoding=UTF-8" >> ${THEME_DIR}/index.theme
  echo "" >> ${THEME_DIR}/index.theme
  echo "[X-GNOME-Metatheme]" >> ${THEME_DIR}/index.theme
  echo "GtkTheme=Canta${color}${size}${radius}" >> ${THEME_DIR}/index.theme
  echo "MetacityTheme=Canta${color}${size}${radius}" >> ${THEME_DIR}/index.theme
  echo "IconTheme=Adwaita" >> ${THEME_DIR}/index.theme
  echo "CursorTheme=Adwaita" >> ${THEME_DIR}/index.theme
  echo "ButtonLayout=menu:minimize,maximize,close" >> ${THEME_DIR}/index.theme

  mkdir -p                                                                           ${THEME_DIR}/gnome-shell
  cp -ur ${SRC_DIR}/src/gnome-shell/{*.svg,extensions,noise-texture.png,pad-osd.css} ${THEME_DIR}/gnome-shell
  cp -ur ${SRC_DIR}/src/gnome-shell/gnome-shell-theme.gresource.xml                  ${THEME_DIR}/gnome-shell
  cp -ur ${SRC_DIR}/src/gnome-shell/assets${ELSE_DARK}                               ${THEME_DIR}/gnome-shell/assets
  cp -ur ${SRC_DIR}/src/gnome-shell/common-assets/{*.svg,dash}                       ${THEME_DIR}/gnome-shell/assets
  cp -ur ${SRC_DIR}/src/gnome-shell/gnome-shell${color}${size}.css                   ${THEME_DIR}/gnome-shell/gnome-shell.css

  mkdir -p                                                                           ${THEME_DIR}/gtk-2.0
  cp -ur ${SRC_DIR}/src/gtk-2.0/{apps.rc,hacks.rc,main.rc}                           ${THEME_DIR}/gtk-2.0
  cp -ur ${SRC_DIR}/src/gtk-2.0/assets${ELSE_DARK}                                   ${THEME_DIR}/gtk-2.0/assets
  cp -ur ${SRC_DIR}/src/gtk-2.0/gtkrc${color}                                        ${THEME_DIR}/gtk-2.0/gtkrc

  cp -ur ${SRC_DIR}/src/gtk/assets                                                   ${THEME_DIR}/gtk-assets

  mkdir -p                                                                           ${THEME_DIR}/gtk-3.0
  ln -sf ../gtk-assets                                                               ${THEME_DIR}/gtk-3.0/assets
  cp -ur ${SRC_DIR}/src/gtk/gtk${color}${size}${radius}.css                          ${THEME_DIR}/gtk-3.0/gtk.css
  [[ ${color} != '-dark' ]] && \
  cp -ur ${SRC_DIR}/src/gtk/gtk-dark${size}${radius}.css                             ${THEME_DIR}/gtk-3.0/gtk-dark.css

  mkdir -p                                                                           ${THEME_DIR}/metacity-1
  cp -ur ${SRC_DIR}/src/metacity-1/assets/*.png                                      ${THEME_DIR}/metacity-1
  cp -ur ${SRC_DIR}/src/metacity-1/metacity-theme-1${color}.xml                      ${THEME_DIR}/metacity-1/metacity-theme-1.xml
  cd ${THEME_DIR}/metacity-1
	ln -s metacity-theme-1.xml metacity-theme-2.xml
	ln -s metacity-theme-1.xml metacity-theme-3.xml

  mkdir -p                                                                           ${THEME_DIR}/unity
  cp -ur ${SRC_DIR}/src/unity/{*.svg,*.png,dash-widgets.json}                        ${THEME_DIR}/unity
  cp -ur ${SRC_DIR}/src/unity/assets${ELSE_LIGHT}                                    ${THEME_DIR}/unity/assets

  mkdir -p                                                                           ${THEME_DIR}/xfwm4
  cp -ur ${SRC_DIR}/src/xfwm4/{*.svg,themerc}                                        ${THEME_DIR}/xfwm4
  cp -ur ${SRC_DIR}/src/xfwm4/assets${ELSE_LIGHT}                                    ${THEME_DIR}/xfwm4/assets
}

install_gdm() {
  local THEME_DIR=${1}/${2}${3}${4}${5}
  local GS_THEME_FILE="/usr/share/gnome-shell/gnome-shell-theme.gresource"
  local UBUNTU_THEME_FILE="/usr/share/gnome-shell/theme/ubuntu.css"

  if [[ -f "$GS_THEME_FILE" ]] && [[ "$(which glib-compile-resources 2> /dev/null)" ]]; then
    echo "Installing '$GS_THEME_FILE'..."
    cp -an "$GS_THEME_FILE" "$GS_THEME_FILE.bak"
    glib-compile-resources \
      --sourcedir="$THEME_DIR/gnome-shell" \
      --target="$GS_THEME_FILE" \
      "$THEME_DIR/gnome-shell/gnome-shell-theme.gresource.xml"
  else
    echo
    echo "ERROR: Failed to install '$GS_THEME_FILE'"
    exit 1
  fi

  if [[ -f "$UBUNTU_THEME_FILE" ]]; then
    echo "Installing '$UBUNTU_THEME_FILE'..."
    cp -an "$UBUNTU_THEME_FILE" "$UBUNTU_THEME_FILE.bak"
    cp -af "$THEME_DIR/gnome-shell/gnome-shell.css" "$UBUNTU_THEME_FILE"
  fi
}

install_icon() {
  show_info "\nInstalling Canta..."

  # Copying files
  cp -ur ${SRC_DIR}/src/icons/Canta ${ICON_DEST_DIR}

  # update icon caches
  gtk-update-icon-cache ${ICON_DEST_DIR}/Canta

  show_info "\nInstallation complete!"
  show_tips "\nIf you want a better experience you should install numix-circle first!"
  show_tips "Because Canta icon theme use numix-icon-theme-circle icon theme for Inherits!\n"
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -g|--gdm)
      gdm='true'
      shift 1
      ;;
    -i|--icon)
      install_icon
      exit 0
      ;;
    -c|--color)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          standard)
            colors+=("${COLOR_VARIANTS[0]}")
            shift
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[1]}")
            shift
            ;;
          light)
            colors+=("${COLOR_VARIANTS[2]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--size)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          standard)
            sizes+=("${SIZE_VARIANTS[0]}")
            shift
            ;;
          compact)
            sizes+=("${SIZE_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -r|--radius)
      shift
      for variant in "${@}"; do
        case "${variant}" in
          standard)
            radiuss+=("${RADIUS_VARIANTS[0]}")
            shift
            ;;
          square)
            radiuss+=("${RADIUS_VARIANTS[1]}")
            shift
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

for color in "${colors[@]:-${COLOR_VARIANTS[@]}}"; do
  for size in "${sizes[@]:-${SIZE_VARIANTS[@]}}"; do
    for radius in "${radiuss[@]:-${RADIUS_VARIANTS[@]}}"; do
      install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}" "${radius}"
    done
  done
done

if [[ "${gdm:-}" == 'true' ]]; then
  install_gdm "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}" "${radius}"
fi

echo
echo Done.
