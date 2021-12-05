#! /bin/bash

show_question() {
  echo -e "\033[1;34m$@\033[0m"
}

show_tips() {
  echo -e "\033[1;32m$@\033[0m"
}

show_dir() {
  echo -e "\033[1;32m$@\033[0m"
}

show_error() {
  echo -e "\033[1;31m$@\033[0m"
}

end() {
  echo -e "\nExiting...\n"
  exit 0
}

continue() {
  show_question "\nDo you want to continue? (y)es, (n)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "\nSorry, try again."; continue;;
  esac
}

replace() {
  show_question "\nFound an existing installation. Replace it? (y)es, (n)o :\n"
  read INPUT
  case $INPUT in
    [Yy]* ) rm -rf $DEST_DIR/Canta;;
    [Nn]* ) ;;
    * ) show_error "\nSorry, try again."; replace $@;;
  esac
}

setup() {
  show_question "\nDo you want to set the theme now? (y)es, (n)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) Canta;;
    [Nn]* ) end;;
    * ) show_error "\nSorry, try again."; setup;;
  esac
}

Canta() {

  # Set Canta Icon Theme

  echo "Setting Canta..."
  gsettings set org.gnome.desktop.interface icon-theme Canta
  echo "Done!"
}

install() {

  # PREVIEW

  # Show destination directory
  echo -e "\nCanta Icon Theme will be installed in:\n"
  show_dir "\t$DEST_DIR"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "\nIt will be available to all users."
  else
    echo -e "\nIf you want to make them available to all users, run this script as root."
  fi

  # continue

  # INSTALL

  # Check destination directory
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  elif [[ -d $DEST_DIR/Canta ]]; then
    replace $DEST_DIR
  fi

  echo -e "\nInstalling Canta..."

  # Copying files

  cp -a Canta $DEST_DIR

  # update icon caches

  gtk-update-icon-cache $DEST_DIR/Canta

  echo -e "\nInstallation complete!"
  show_tips "\nIf you want a better experience you should install Tela-circle first!"
  show_tips "Because Canta icon theme use Tela-circle icon theme for Inherits!"

  setup

}

remove() {

  # PREVIEW

  # Show installation directory
  if [[ -d $DEST_DIR/Canta ]]; then
    echo -e "\nCanta Icon Theme installed in:\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\nIt will remove for all users."
    else
      echo -e "\nIt will remove only for current user."
    fi

    continue

  else
    show_error "\nCanta Icon Theme is not installed in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\nRemoving Canta ..."

  # Removing files

  rm -rf $DEST_DIR/Canta

  echo "Removing complete!"
  echo "I hope to see you soon."
}

main() {
  show_question "What you want to do: (i)nstall, (r)emove : \n"
  read INPUT
  case $INPUT in
    [Ii]* ) install;;
    [Rr]* ) remove;;
    * ) show_error "\nSorry, try again."; main;;
  esac
}

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/icons"
else
  DEST_DIR="$HOME/.local/share/icons"
fi

echo -e "\e[1m\n+----------------------------------------------+"
echo -e "|      Canta Icon Theme Installer Script       |"
echo -e "+----------------------------------------------+\n\e[0m"

main
