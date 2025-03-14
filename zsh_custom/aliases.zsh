# git
alias glm="git log --oneline master.."
alias gld="git log --oneline develop.."
alias gccp="git rev-parse --short HEAD | tr -d '\n' | pbcopy"
alias gbb=brancher
alias gbt=tagger
alias gn=git_next

alias diff="colordiff"
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
