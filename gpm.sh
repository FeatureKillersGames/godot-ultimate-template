#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

if [[ "$1" = "init" ]];then
    mkdir -p $SCRIPT_DIR/addons
    mkdir -p $SCRIPT_DIR/assets/gdignore
    touch $SCRIPT_DIR/assets/gdignore/.gdignore
    mkdir -p $SCRIPT_DIR/assets/sounds
    mkdir -p $SCRIPT_DIR/assets/textures
    mkdir -p $SCRIPT_DIR/assets/textures/ui
    mkdir -p $SCRIPT_DIR/assets/translations
    mkdir -p $SCRIPT_DIR/build/android
    mkdir -p $SCRIPT_DIR/build/linux
    mkdir -p $SCRIPT_DIR/build/web
    mkdir -p $SCRIPT_DIR/build/win
    touch $SCRIPT_DIR/build/.gdignore
    mkdir -p $SCRIPT_DIR/resources/materials
    mkdir -p $SCRIPT_DIR/resources/meshes
    mkdir -p $SCRIPT_DIR/resources/shaders
    mkdir -p $SCRIPT_DIR/resources/themes
    mkdir -p $SCRIPT_DIR/scenes
    mkdir -p $SCRIPT_DIR/scripts
    git init
    git add .
    git commit -m "init"
    git reset $(git commit-tree "HEAD^{tree}" -m "init")
    git remote remove origin
elif [[ "$1" = "addon" ]];then
    read -p "Add godot-easy-multiplayer y/n:" godot_easy_multiplayer
    read -p "Add godot-transitions y/n:" godot_transitions
    read -p "Add godot-fast-ui y/n:" godot_fast_ui
    read -p "Add godot-simple-saves y/n:" godot_simple_saves
    message="add addon "
    if [[ "$godot_easy_multiplayer" == "y" ]] || [[ "$godot_easy_multiplayer" == "yes" ]]; then
        commit=true
        message="${message} godot-easy-multiplayer"
        git submodule add git@github.com:FeatureKillersGames/godot-easy-multiplayer.git addons/godot-easy-multiplayer
    fi
    if [[ "$godot_transitions" == "y" ]] || [[ "$godot_transitions" == "yes" ]]; then
        commit=true
        message="${message} godot-transitions"
        git submodule add git@github.com:FeatureKillersGames/godot-transitions.git addons/godot-transitions
    fi
    if [[ "$godot_fast_ui" == "y" ]] || [[ "$godot_fast_ui" == "yes" ]]; then
        commit=true
        message="${message} godot-fast-ui"
        git submodule add git@github.com:FeatureKillersGames/godot-fast-ui.git addons/godot-fast-ui
    fi
    if [[ "$godot_simple_saves" == "y" ]] || [[ "$godot_simple_saves" == "yes" ]]; then
        commit=true
        message="${message} godot-simple-saves"
        git submodule add git@github.com:FeatureKillersGames/godot-simple-saves.git addons/godot-simple-saves
    fi
    if [[ -n $commit ]]; then
        git add .
        git commit -m $message
    fi
fi
