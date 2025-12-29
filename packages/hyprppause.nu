#!/usr/bin/env nu

use ./ppause.nu *

export def main [] {
        ppause (hyprctl -j activewindow | from json | get pid)
}
