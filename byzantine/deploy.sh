#!/usr/bin/env bash

DIR=~/.config/dzen-dhall
dzen-dhall --config-dir "$DIR" init
cp -r . "$DIR"
