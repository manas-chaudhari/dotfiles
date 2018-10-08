#!/usr/bin/env bash

main() {
    configure_trackpad
    configure_dock
    configure_system
}

function configure_trackpad() {
    # Trackpad: enable tap to click for this user and for the login screen
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

    # Increase sound quality for Bluetooth headphones/headsets
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    # Disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

    # Disable auto-correct
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    # To Automate:

    # Three Finger Drag

}
function configure_dock() {
    quit "Dock"

    # Wipe all (default) app icons from the Dock
    defaults write com.apple.dock persistent-apps -array
    # Show only open applications in the Dock
    defaults write com.apple.dock static-only -bool true

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Remove the auto-hiding Dock delay
    defaults write com.apple.dock autohide-delay -float 0
}

function configure_system() {
    # Disable Gatekeeper entirely to get rid of \
    # “Are you sure you want to open this application?” dialog
    sudo spctl --master-disable
}

function quit() {
    app=$1
    killall "$app" > /dev/null 2>&1
}

function open() {
    app=$1
    osascript << EOM
tell application "$app" to activate
EOM
}

main