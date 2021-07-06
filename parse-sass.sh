#!/bin/bash

if [ ! "$(which sassc 2> /dev/null)" ]; then
  echo sassc needs to be installed to generate the css.
  exit 1
fi

_COLOR_VARIANTS=('' '-dark' '-light')
if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_SIZE_VARIANTS=('' '-compact')
if [ ! -z "${SIZE_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _SIZE_VARIANTS <<< "${SIZE_VARIANTS:-}"
fi

SASSC_OPT="-M -t expanded"

for color in "${_COLOR_VARIANTS[@]}"; do
    for size in "${_SIZE_VARIANTS[@]}"; do
        echo "==> Generating the 3.0 gtk${color}${size}.css..."
        sassc $SASSC_OPT src/gtk/3.0/gtk${color}${size}.{scss,css}
        echo "==> Generating the 4.0 gtk${color}${size}.css..."
        sassc $SASSC_OPT src/gtk/4.0/gtk${color}${size}.{scss,css}
        echo "==> Generating the 3.36 gnome-shell${color}${size}.css..."
        sassc $SASSC_OPT src/gnome-shell/shell-3-36/gnome-shell${color}${size}.{scss,css}
        echo "==> Generating the 40.0 gnome-shell${color}${size}.css..."
        sassc $SASSC_OPT src/gnome-shell/shell-40-0/gnome-shell${color}${size}.{scss,css}
    done
done

echo "==> Generating the cinnamon.css..."
sassc $SASSC_OPT src/cinnamon/cinnamon.{scss,css}
echo "==> Generating the cinnamon-dark.css..."
sassc $SASSC_OPT src/cinnamon/cinnamon-dark.{scss,css}

