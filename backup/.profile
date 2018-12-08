
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

function compress() {
	curl --user api:$TINYPNG_API \
             --data-binary $1 -i https://api.tinify.com/shrink
}

ssh-tunnel() {
	ssh -L "$3":localhost:"$2" $1
}

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# Pip
export PATH=$PATH:$HOME/Library/Python/2.7/bin


# Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN


# Custom binaries
export PATH=$PATH:$HOME/install/bin


# Android
export ANDROID_HOME=$HOME/Library/Android/sdk


# Erlang
export PATH="/usr/local/opt/erlang@18/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/erlang@18/lib"


#ErlangInstaller
export PATH="~/.erlangInstaller/default/bin:$PATH"
