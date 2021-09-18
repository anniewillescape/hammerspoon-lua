#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# make symlink to ~/.hammerspoon/init.lua
ln -sf $SCRIPT_DIR/init.lua ~/.hammerspoon/init.lua