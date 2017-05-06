
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.shenyunhang-vimrc"

(curl https://raw.github.com/shenyunhang/vimrc/master/bootstrap.sh -L)> $APP_PATH/bootstrap.sh

sh bootstrap.sh


