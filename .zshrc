##------------------------------------##
## .zshrc for Ubuntu version 1.0      ##
## last updated : 2009/11/29          ##
##------------------------------------##

# 只今「どっとふぁいる」を読み込んでます。
echo "Loading dot.zshrc..."

# coreファイルのサイズを0に抑制する。
unlimit
limit core 0
limit -s

# ファイルを作成した時の標準モードの設定。
umask 022

# 履歴機能に関する設定。
HISTFILE=$HOME/.zsh-history           # 履歴をファイルに保存する
HISTSIZE=100000                       # メモリ内の履歴の数
SAVEHIST=100000                       # 保存される履歴の数
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力する

# 色付きプロントに関する設定。
if [ $UID = 0 ]; then
	setopt	prompt_subst
	PROMPT='%{[$[32+$RANDOM % 5]m%}'"%n@%m[%h]%b#%{[m%}%u "
	RPROMPT='%{[33m%}[%~]%{[m%}'
else
	setopt	prompt_subst
	PROMPT='%{[$[32+$RANDOM % 5]m%}'"%n@%m[%h]%b%%%{[m%}%u "
	RPROMPT='%{[33m%}[%~]%{[m%}'
fi

# pathの設定。
#mailpath=(/var/mail/$USERNAME)
path=($HOME/bin)
path=($path /bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin)
path=($path /usr/local/clockspeed/bin)
path=($path /usr/libexec /usr/local/libexec)
path=($path /usr/pkg/bin /usr/pkg/sbin)
path=($path $X11HOME/bin /usr/X11R6/{sbin,bin})
manpath=(/usr/local/man /usr/share/man /usr/pkg/man)
watch=(notme)

## ---- 以下、設定に関するファイルを読み込む。---- ##
## /dot.zsh/.zsh_options      (オプション設定)     ##
## /dot.zsh/.zsh_common       (alias設定)          ##
##-------------------------------------------------##

# オプションの設定ファイルを読み込む。
if [ -f ~/dot.zsh/.zsh_options ]; then
  source ~/dot.zsh/.zsh_options
fi

# aliasの設定ファイルを読み込む。
setenv () {export $1="$@[2,-1]"}
calias () {alias $1="$@[2,-1]"}
source ~/dot.zsh/.zsh_common

## ----- ファイルの読み込みは以上。----- ##

# 補完候補の設定
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'	
autoload -U compinit
compinit
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 一覧表示された補完候補を矢印で選択できる
zstyle ':completion:*:default' menu select=1

# 補完キャッシュ
zstyle ':completion:*' use-cache true

# 補完の設定。
#cdpath=(.. ~)

# 補完候補から外す。
#fignore=(.o \~)

# 環境設定。
export BLOCKSIZE=1024K
export LS_OPTIONS
export LANG=ja_JP.UTF-8
export PAGER=/usr/bin/less
export EDITOR=vi
export CANNAHOST=localhost
export WORDCHARS='*?_.[]~=&;!#$%^(){}<>'

# キーバインドの設定。
bindkey	-m				# Metaキーを有効にする。
bindkey -e				# emacsライクなキーバインド。
bindkey "^U" backward-kill-line		# C-uでカーソルから行頭までを消去
bindkey "^W" kill-region		# マーク位置からカーソルまでを消去
bindkey "^H" vi-backward-kill-word	# C-hでカーソル前の単語を消去
#bindkey "^[h" backward-kill-word	#
bindkey "^Z" accept-and-hold		#
#bindkey -v 				# viライクなキーバインド。

# 画面をクリアします。
clear

# 最後はこんなメッセージを表示してみました（笑）。
os_type=`uname -rs`
echo "Welcome to $os_type World !! Happy Hacking !!\n"

