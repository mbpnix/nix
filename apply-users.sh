#!/bin/sh
pushd ~/dotfiles
home-manager switch -f ./users/master/home.nix
popd
