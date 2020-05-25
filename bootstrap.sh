#!/usr/bin/env bash

#   Copyright 2014 Steve Francia
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

set -x
set -e

############################  SETUP PARAMETERS
app_name='shenyunhang-vimrc'
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.shenyunhang-vimrc"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/shenyunhang/vimrc.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='0.1'
debug_mode='0'
fork_maintainer='0'
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/VundleVim/Vundle.vim"

############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue.\n$2"
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

############################ SETUP FUNCTIONS

do_backup() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        msg "Attempting to back up your original vim configuration."
        today=`date +%Y%m%d_%s`
        for i in "$1" "$2" "$3"; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
        done
        ret="$?"
        success "Your original vim configuration has been backed up."
        debug
   fi
}

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"

    msg "Trying to update $repo_name"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        #git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        git clone "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        #cd "$repo_path" && git pull origin "$repo_branch"
        cd "$repo_path" && git reset --hard HEAD && git pull origin master
        ret="$?"
        success "Successfully updated $repo_name"
    fi

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    #lnif "$source_path/.vimrc.bundles" "$target_path/.vimrc.bundles"
    #lnif "$source_path/.vimrc.before"  "$target_path/.vimrc.before"
    lnif "$source_path/.vim"           "$target_path/.vim"

    #if program_exists "nvim"; then
    #    lnif "$source_path/.vim"       "~/.config/nvim"
    #    lnif "$source_path/.vimrc"     "~/.config/nvim/init.vim"
    #fi

    #touch  "$target_path/.vimrc.local"

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

setup_fork_mode() {
    local source_path="$2"
    local target_path="$3"

    if [ "$1" -eq '1' ]; then
        touch "$target_path/.vimrc.fork"
        touch "$target_path/.vimrc.bundles.fork"
        touch "$target_path/.vimrc.before.fork"

        lnif "$source_path/.vimrc.fork"         "$target_path/.vimrc.fork"
        lnif "$source_path/.vimrc.bundles.fork" "$target_path/.vimrc.bundles.fork"
        lnif "$source_path/.vimrc.before.fork"  "$target_path/.vimrc.before.fork"

        ret="$?"
        success "Created fork maintainer files."
        debug
    fi
}

setup_vundle() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'

#    vim \
#        -u "$1" \
#        "+set nomore" \
#        "+BundleInstall!" \
#        "+BundleClean" \
#        "+qall"

    vim +PluginInstall +qall
    export SHELL="$system_shell"

    success "Now updating/installing plugins using Vundle"
    debug
}

setup_nvim() {
    mkdir -p ~/.config
    ln -s ~/.vim ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim
    success "Setting up nvim"
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "vim"
program_must_exist "git"
program_must_exist "ctags"
program_must_exist "pip3"
program_must_exist "cmake"
program_must_exist "pep8" "you can install with pip3: pip3 install pep8"
#program_must_exist "autopep8" "you can install with pip3: pip3 install autopep8"
program_must_exist "yapf" "you can install with pip3: pip3 install yapf"
program_must_exist "powerline" "pip3 install git+git://github.com/powerline/powerline"

msg             "Going to install Jedi - an awesome autocompletion/static analysis library for Python"
sudo pip3 install jedi


do_backup       "$HOME/.vim" \
                "$HOME/.vimrc" \
                "$HOME/.gvimrc"

sync_repo       "$APP_PATH" \
                "$REPO_URI" \
                "$REPO_BRANCH" \
                "$app_name"

create_symlinks "$APP_PATH" \
                "$HOME"

setup_fork_mode "$fork_maintainer" \
                "$APP_PATH" \
                "$HOME"

sync_repo       "$HOME/.vim/bundle/Vundle.vim" \
                "$VUNDLE_URI" \
                "master" \
                "vundle"

setup_nvim

setup_vundle    "$APP_PATH/.vimrc.bundles.default"



#编译youcompleteme插件
msg "编译YouCompleteMe插件"
cd $HOME/.vim/bundle/YouCompleteMe/
git checkout d556a43c1af6a4e4075e875934e250f589df0dee
git submodule update --init --recursive
#python3 ./install.py
python3 ./install.py --clang-completer
#python3 ./install.py --clang-completer --system-libclang
lnif "$APP_PATH/.ycm_extra_conf.py"         "$HOME/.ycm_extra_conf.py"
#编译youcompleteme插件

# ctags
msg             "\n请使用ctags生成c/c++头文件索引：\nctags -R -f ~/.vim/systags --c-kinds=+p --fields=+S /usr/include /usr/local/include"
cd ~
ctags -R -f ~/.vim/systags --c-kinds=+p --fields=+S /usr/include /usr/local/include

msg             "\nThanks for installing $app_name."
msg             "© `date +%Y` http://121.192.180.179"
