# Setup fzf
# ---------
if [[ ! "$PATH" == */home/matteo/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/matteo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/matteo/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/matteo/.fzf/shell/key-bindings.bash"
