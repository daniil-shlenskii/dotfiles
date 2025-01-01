__SHELL_NAME=$(basename $SHELL)

# autocompletion
case $__SHELL_NAME in
zsh)
      autoload -Uz compinit
      compinit
      ;;
esac

case $__SHELL_NAME in
bash)
    if [ -f $PIXI_HOME/envs/bash-completion/share/bash-completion/bash_completion ]; then
    . $PIXI_HOME/envs/bash-completion/share/bash-completion/bash_completion
    fi
    ;;
esac

if [ ! -z $(which starship) ]; then
    case $__SHELL_NAME in
    bash | zsh)
      eval "$(starship init $__SHELL_NAME)"
      ;;
    esac
fi
