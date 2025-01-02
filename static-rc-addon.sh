__SHELL_NAME=$(basename $SHELL)

# zellij
alias zlj="zellij --config ${XGD_CONFIG_HOME}/zellij/config.kdl"
alias zellij="zellij --config ${XGD_CONFIG_HOME}/zellij/config.kdl"

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
