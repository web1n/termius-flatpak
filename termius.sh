#!/bin/bash

if [[ "$XMODIFIERS" =~ "fcitx" ]]; then
  [ -z "$GTK_IM_MODULE" ] && export GTK_IM_MODULE=fcitx
elif [[ "$XMODIFIERS" =~ "ibus" ]]; then
  [ -z "$GTK_IM_MODULE" ] && export GTK_IM_MODULE=ibus
fi

zypak-wrapper.sh /app/termius/termius-beta "$@"
