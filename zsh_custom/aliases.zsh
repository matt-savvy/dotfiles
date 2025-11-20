# nvim
alias vim=nvim

# git
alias glm='git log --oneline $(git_main_branch)..'
alias gld="git log --oneline develop.."
alias gccp="git rev-parse --short HEAD | tr -d '\n' | pbcopy"
alias gccl="gh_commit | tr -d '\n' | pbcopy"
alias gbc=git_branch
alias gbb=brancher
alias gbt=tagger
alias gn=git_next

alias diff="colordiff"
alias sdiff="diff --side-by-side --width 200"
# alias vim="nvim"

alias cdd="dev_cd"

# mix
alias mt="mix_test"
alias mtf="mix test --failed"
alias mf="mix format"

# go
alias gof="go fmt ./..."
alias got="go test ./..."
alias gov="go vet ./..."
alias cobra="cobra-cli"

# sqlite
alias sqlite3="rlwrap sqlite3"

