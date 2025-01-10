#!/bin/bash
branch=$(hostname)
files=".zshrc .tmux .Xresources .vimrc .tmux.conf"
here=$(pwd)
set -x

gitdo() {
  git checkout -b $branch
}

mover() {
    # We want to avoid doing this incrementally which could
    # potentially just clobber all the files on top of each other
    # since mv is destructive
    (
    cd $HOME
    mv -i $files $here/dotfiles
    )
}

linker() {
    for path in $files; do
        ln -s $here/dotfiles/$path $HOME
    done
}

#gitdo
#mover
linker
git commit -am "initial commit for $branch"
