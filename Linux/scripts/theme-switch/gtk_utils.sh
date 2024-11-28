#!/usr/bin/env bash

# Get Path of Current Script
DIR=`dirname $0`

USER_GTK_CONFIG_FILEPATH="$HOME/.config/gtk-3.0/settings.ini"
USER_GTK4_CONFIG_FILEPATH="$HOME/.config/gtk-4.0/settings.ini"

GTK_THEME_DIR="$DIR/gtk-configs"
GTK4_THEME_DIR="$DIR/gtk-4-configs"

# Helper function for explicitly setting GTK interface's theme.
function set_gtk_theme() {
  THEME_NAME="$1"

  # GTK theme paths
  GTK_SETTINGS_CONFIG_PATH="$GTK_THEME_DIR/settings-${THEME_NAME}.ini"
  GTK4_SETTINGS_CONFIG_PATH="$GTK4_THEME_DIR/settings-${THEME_NAME}.ini"

  # Update gtk4 settings
  gsettings set org.gnome.desktop.interface gtk-theme \
    $(cat "$GTK4_SETTINGS_CONFIG_PATH" | rg -o "gtk-theme-name=(.*)$" --replace='$1')

  # Expected 'prefer-light' or 'prefer-dark'.
  # Default value is 'default'.
  gsettings set org.gnome.desktop.interface color-scheme "prefer-$1"

  # Update GTK theme files
  cp "$GTK_SETTINGS_CONFIG_PATH" "$USER_GTK_CONFIG_FILEPATH"
  cp "$GTK4_SETTINGS_CONFIG_PATH" "$USER_GTK4_CONFIG_FILEPATH"
}
