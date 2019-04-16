#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"
SRC_FILE="assets.svg"
ASSETS_DIR="assets"

COMMON_INDEX="common-assets.txt"
COMMON_SRC_FILE="common-assets.svg"
COMMON_ASSETS_DIR="common-assets"

for i in `cat $INDEX`
do 
if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png 
fi
if [ -f $ASSETS_DIR/$i@2.png ]; then
    echo $ASSETS_DIR/$i@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$ASSETS_DIR/$i@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i@2.png 
fi

done

for i in `cat $COMMON_INDEX`
do 
if [ -f $COMMON_ASSETS_DIR/$i.png ]; then
    echo $COMMON_ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $COMMON_ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-png=$COMMON_ASSETS_DIR/$i.png $COMMON_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $COMMON_ASSETS_DIR/$i.png 
fi
if [ -f $COMMON_ASSETS_DIR/$i@2.png ]; then
    echo $COMMON_ASSETS_DIR/$i@2.png exists.
else
    echo
    echo Rendering $COMMON_ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              --export-png=$COMMON_ASSETS_DIR/$i@2.png $COMMON_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $COMMON_ASSETS_DIR/$i@2.png 
fi

done
exit 0
