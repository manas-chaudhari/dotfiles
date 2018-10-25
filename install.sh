#!/usr/bin/env bash

set -e

# TODO:
# - Setup VSCode extensions: vim
# - Setup Android Studio plugin: IdeaVim

main() {
	ask_for_sudo
	install_homebrew
	install_brew_packages

	install_pip
	install_prezto
	change_shell_to_zsh
	
	restore_mackup

	restore_osx_settings
}

function install_homebrew() {
	# Check for Homebrew and install if we don't have it
	if test ! $(which brew); then
		echo "Installing Homebrew"
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
}

function install_brew_packages() {
	echo "Installing Brew Packages"

	# Install all our dependencies with bundle (See Brewfile)
	brew bundle
}

function change_shell_to_zsh() {
	echo "Changing shell to zsh"
	if grep --quiet zsh <<< "$SHELL"; then
		echo "zsh already default"
	else
		# Make ZSH the default shell environment
		sudo chsh -s $(which zsh)
	fi
}

function install_pip() {
	echo "Installing pip"
	sudo easy_install pip
}

function install_prezto() {
	echo "Installing Prezto"
	if test ! -e $HOME/.zprezto; then
		zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"'
	else
		echo "Prezto already installed"
	fi
}

function restore_mackup() {
	symlink $PWD/.mackup.cfg $HOME/.mackup.cfg
	symlink $PWD/.mackup $HOME/.mackup

	mackup restore
}

function restore_osx_settings() {
	echo "Restoring OSX settings"
	./osx.sh
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

function ask_for_sudo() {
    echo "Prompting for sudo password..."
    if sudo --validate; then
        # Keep-alive
        while true; do sudo --non-interactive true; \
            sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
        echo "Sudo credentials updated."
    else
        echo "Obtaining sudo credentials failed."
        exit 1
    fi
}

main
