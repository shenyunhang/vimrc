
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.shenyunhang-vim"

(curl https://raw.github.com/shenyunhang/vim/master/bootstrap.sh -L)> $APP_PATH/bootstrap.sh

sh bootstrap.sh


