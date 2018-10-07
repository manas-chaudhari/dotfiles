#!/usr/bin/env bash

set -e

main() {
	install_homebrew
	install_brew_packages
	
	restore_mackup
}

function install_homebrew() {
	echo "Setting up Homebrew"

	# Check for Homebrew and install if we don't have it
	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

function install_brew_packages() {
	# Update Homebrew recipes
	brew update

	# Install all our dependencies with bundle (See Brewfile)
	brew tap homebrew/bundle
	brew bundle
}

function restore_mackup() {
	symlink .mackup.cfg $HOME/.mackup.cfg

	mackup restore
}

function symlink() {
	point_to=$1
	destination=$2
	destination_dir=$(dirname "$destination")

	if test ! -e "$destination_dir"; then
		echo "Creating ${destination_dir}"
		mkdir -p "$destination_dir"
	fi
	if rm -rf "$destination" && ln -s "$point_to" "$destination"; then
		echo "Symlinking ${point_to} done."
	else
		echo "Symlinking ${point_to} failed."
		exit 1
	fi
}

main
