
############
## CONFIG ##
############

export PS1=">"
export PS2=""
export PATH=".:$PATH"
export EDITOR="vim"
#export TERM="linux"
export MAIL="ricardo.mazeto@live.com"
export MAILDIR="~/mail/ricardo.mazeto.live.folder/"
stty stop undef
stty start undef

export LESS_TERMCAP_mb=$(tput bold; tput setaf 5) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 3) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 2; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 1) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

export LESS="--RAW-CONTROL-CHARS"
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP

###############
## FUNCTIONS ##
###############

trans() {
    pushd . > /dev/null;
    cd /mnt/sda2/prg/trans > /dev/null;
    ./translate.awk pt:en $1;
    popd > /dev/null;
}

trad() {
    pushd . > /dev/null;
    cd /mnt/sda2/prg/trans > /dev/null;
    ./translate.awk en:pt $1;
    popd > /dev/null;
}

ytw() {
    a=$(echo $1 | sed -e "s/https:\/\/www.youtube.com\/watch?v=//g");
    mpv --ytdl-format=18 ytdl://$a;
}

gh() {
    # gen new ssh key and add it to ssh agent
    # https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

    # add ssh key to github account
    # https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

    # gh --new-repo
    if [ $1 == '--new-repo' ]; then

        # USERNAME
        username=$(git config user.name) > /dev/null 2>&1;
        if [ $username == "" ]; then
            echo "Couldn't find user name. Run git config --global user.name USERNAME";
            return 1;
        fi;

        # REPONAME
        reponame="";
        read -p "repo's name (hit enter to use $(basename `pwd`)): " reponame;

        # FOLDER
        token=$(git config github.token);
        if [ $token == "" ]; then
            echo "Couldn't find github token.";
            echo "Run git config --global github.token TOKEN";
            echo "You can get your token at https://github.com/settings/tokens";
            return 1;
        fi;

        echo "Creating repo $reponame ($username:$token)...";

        if [ ! -d ".git" ]; then
            echo "Initializing local git repo";
            git init;
        fi;

        curl -u "$username:$token" \
             https://api.github.com/user/repos \
             -d '{"name": "'$reponame'"}' > /dev/null 2>&1;

        echo "Syncing";
        git remote add origin git@github.com:$username/$reponame.git;
        git push -u origin master;
        echo "Done.";
    fi;
}

note() {
    if [ $# == 0 ]; then joe ~/.notes;
    elif [ $# >= 1 ]; then echo $1 >> ~/.notes;
        echo "note saved";
    fi;
 }

8bitsct() {
    if [ $TERM == "linux" ]; then
        # 0 1 2 3 . 4 5 6 7 . 8 9 a b . c d e f
        sudo printf '\033]P0000000'; # black
        sudo printf '\033]P1a00000'; # red
        sudo printf '\033]P2208040'; # green
        sudo printf '\033]P3c08000'; # yellow
        sudo printf '\033]P4004080'; # blue
        sudo printf '\033]P5602080'; # magenta
        sudo printf '\033]P6008080'; # cyan
        sudo printf '\033]P7c0a080'; # white
        # 6 8 c
        sudo printf '\033]P8402040'; # black
        sudo printf '\033]P9e02040'; # red
        sudo printf '\033]PA80c040'; # green
        sudo printf '\033]PBe0c000'; # yellow
        sudo printf '\033]PC4060c0'; # blue
        sudo printf '\033]PDa04080'; # magenta
        sudo printf '\033]PE60c080'; # cyan
        sudo printf '\033]PFe0c040'; # white
    fi;
}

dark.warm.theme() {
    #if [ $TERM = "linux" ]; then
        sudo printf '\033]P01a1813';# black
        sudo printf '\033]P1991f1f';# red
        sudo printf '\033]P25c991f';# green
        sudo printf '\033]P3997b1f';# yellow
        sudo printf '\033]P41f3e99';# blue
        sudo printf '\033]P5991f70';# magenta
        sudo printf '\033]P61f9999';# cyan
        sudo printf '\033]P7ccbc95';# white
        sudo printf '\033]P8333026';# black
        sudo printf '\033]P9e62e2e';# red
        sudo printf '\033]PA8ae62e';# green
        sudo printf '\033]PBe6b82e';# yellow
        sudo printf '\033]PC2e5ce6';# blue
        sudo printf '\033]PDe62ea9';# magenta
        sudo printf '\033]PE2ee6e6';# cyan
        sudo printf '\033]PFe6d7ab';# white
    #fi;
}

minit() {
    8bitsct;
    sudo setfont /usr/share/kbd/consolefonts/ter-112n.psf.gz;
    sudo cpupower frequency-set -u 800Mhz;
    sudo mount -w /dev/sda2 /mnt/sda2;
    sudo mount -w /dev/sr0 /mnt/cdr;
    sudo swapon ~/.swapfile;
    xset r rate 200 30;
    sudo wifi-menu;
    xbindkeys;
    xset -b;
}

wn() {
    wordnet $1 -over;
}

#############
## ALIASES ##
#############

alias cls="clear"
alias rmd="recordmydesktop"
alias ytdl="youtube-dl -i"
alias gdb="gdb --quiet"
alias vol="pamixer --set-volume"
alias bhad="bindechexascii"
alias cgrep="grep --color=always"
alias chrome="google-chrome-stable"
alias ls="ls --color=always --group-directories-first"
alias tmux="tmux -f $HOME.config/tmux.conf"
alias pacman="pacman --color=always"
alias transmission="transmission-daemon; transmission-remote-cli"
alias irc="irssi --config ~/.config/irssi.cfg --config ~/.config/irssi.config --config ~/.config/irrsi.startup --config ~/.config/irssi.theme.cfg -c irc.freenode.net -n mazeto -w `cat ~/.irssi/pw`"
alias mail="mutt -F ~/.config/muttrc"
alias mocp="mocp -T green_theme"
