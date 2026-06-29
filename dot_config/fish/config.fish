if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting (date)

    fish_vi_key_bindings
    # this is important so that i can use neo2 layout with fish
    bind -M insert \e\[5\;4\~ true
    atuin init fish | source

end

fish_add_path ~/.config/emacs/bin
# user-space homebrew (work laptop, no sudo); harmless if absent (private laptop uses /opt)
if test -d ~/homebrew/bin
    fish_add_path ~/homebrew/bin
end

# aliases
alias vim='nvim-chad'
alias j='autojump'
alias ls='eza'
alias l='eza --long --group --all --git'
alias tree='eza --tree'
alias cat='bat'
alias c='claude'
alias cr='claude --resume'
alias cc='claude --dangerously-skip-permissions'

# git aliase
alias g='git'
alias gfa='git fetch --all --prune --jobs=10'
alias gw='git worktree'
alias gwa='git worktree add'
alias gwab='git worktree add -b'
alias gwl='git worktree list'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'

alias gcm='git checkout (git_main_branch)'
alias gcd='git checkout (git_develop_branch)'
alias gcmsg='git commit -m'
alias gco='git checkout'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcas='git commit -a -s'
alias gcasm='git commit -a -s -m'
alias gcb='git checkout -b'

alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'

alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'

alias nvimdiff='nvim -d'
alias vimdiff='nvim -d'

alias i='iex'
alias ips='iex -S mix phx.server'
alias ipsc='iex --sname worker --cookie mycookie -S mix phx.server'
alias e2e='iex -S mix e2e'
alias ism='iex -S mix'
alias m='mix'
alias mab='mix archive.build'
alias mai='mix archive.install'
alias mat='mix app.tree'
alias mc='mix compile'
alias mcf='mix compile --force'
alias mcv='mix compile --verbose'
alias mcl='mix clean'
alias mca='mix do clean, deps.clean --all'
alias mco='mix coveralls'
alias mcoh='mix coveralls.html'
alias mdoc='mix docs'
alias mdl='mix dialyzer'
alias mdlp='mix dialyzer --plt'
alias mcr='mix credo'
alias mcrs='mix credo --strict'
alias mcx='mix compile.xref'
alias mdc='mix deps.compile'
alias mdg='mix deps.get'
alias mdgc='mix do deps.get, deps.compile'
alias mdu='mix deps.update'
alias mdt='mix deps.tree'
alias mdua='mix deps.update --all'
alias mdun='mix deps.unlock'
alias mduu='mix deps.unlock --unused'
alias meb='mix escript.build'
alias mec='mix ecto.create'
alias mecm='mix do ecto.create, ecto.migrate'
alias med='mix ecto.drop'
alias mem='mix ecto.migrate'
alias megm='mix ecto.gen.migration'
alias merb='mix ecto.rollback'
alias mers='mix ecto.reset'
alias mes='mix ecto.setup'
alias mge='mix gettext.extract'
alias mgem='mix gettext.extract --merge'
alias mgm='mix gettext.merge priv/gettext'
alias mho='mix hex.outdated'
alias mlh='mix local.hex'
alias mn='mix new'
alias mns='mix new --sup'
alias mpd='mix phx.digest'
alias mpgc='mix phx.gen.channel'
alias mpgco='mix phx.gen.context'
alias mpgh='mix phx.gen.html'
alias mpgj='mix phx.gen.json'
alias mpgl='mix phx.gen.live'
alias mpgm='mix phx.gen.model'
alias mpgs='mix phx.gen.secret'
alias mpn='mix phx.new'
alias mpr='mix phx.routes'
alias mps='mix phx.server'
alias mr='mix run'
alias mrnh='mix run --no-halt'
alias mrl='mix release'
alias msn='mix scenic.new'
alias msne='mix scenic.new.ezample'
alias msnn='mix scenic.new.nerves'
alias msr='mix scenic.run'
alias mt='mix test'
alias mtc='mix test --cover'
alias mtf='mix test --failed'
alias mtmf='mix test --max-failures'
alias mts='mix test --stale'
alias mtw='mix test.watch'
alias mx='mix xref'
alias mf='mix format'

# search stuff
bind \cs "~/dotfiles/bin/tmux-sessionizer.sh"

# starship
starship init fish | source

# mise — prefer user-space install (~/homebrew, work laptop); else system mise (private laptop)
if test -x ~/homebrew/bin/mise
    ~/homebrew/bin/mise activate fish | source
else if type -q mise
    mise activate fish | source
end

# autojump (`j`) — source from whichever brew prefix has it
for ajprefix in ~/homebrew /opt/homebrew /usr/local
    if test -f $ajprefix/share/autojump/autojump.fish
        source $ajprefix/share/autojump/autojump.fish
        break
    end
end
set -g theme_color_scheme CatppuccinMocha

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

fish_add_path ~/.local/bin ~/.cargo/bin
direnv hook fish | source
set LS_COLORS $(vivid generate catppuccin-mocha)

function nvim-chad
    env NVIM_APPNAME=nvim-chad nvim
end

function nvim-yum
    env NVIM_APPNAME=nvim-yum nvim
end

function nvims
    set items nvim-yum nvim-chad
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config = " --height=~50% --layout=reverse --border --exit-0)
    if [ -z $config ]
        echo "Nothing selected"
        return 0
    else if [ $config = default ]
        set config ""
    end
    env NVIM_APPNAME=$config nvim $argv
end

bind \ca 'nvims\n'```

fzf --fish | source

set -gx ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file_bytes 1024000"

set -gx EDITOR nvim
set -gx VISUAL nvim

set -x CHANNEL_SERVICE_HOST localhost

# Set Emacs path for Doom (GUI, no-native-comp build, workaround for macOS 26 libgccjit bug)
set -x EMACS /nix/store/18gm0v6kbqhpb5vzi8znf19a4j9h6rk8-emacs-30.2/bin/emacs
alias emacs="$EMACS"
alias doom="~/.config/emacs/bin/doom"

# Perplexity API Key — stored in ~/.config/fish/conf.d/secrets.fish (not tracked by git)
# To set: echo 'set -gx PERPLEXITY_API_KEY "your-key-here"' >> ~/.config/fish/conf.d/secrets.fish
alias jjfix "jj resolve --tool mergiraf; jj resolve"
fish_add_path $HOME/.local/bin

# aqua
fish_add_path /Users/Friedrich.Pfitzmann/.local/share/aquaproj-aqua/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/Friedrich.Pfitzmann/.lmstudio/bin
# End of LM Studio CLI section

