logaling-command zsh completion file
===========

logaling-command の zsh 補完定義ファイルです。現在、version 0.1.3 に対応しています。
必要そうなものは大体実装されています(のつもりです)。

## インストール
他の補完定義ファイルと同じ場所に配置してください。例えば、
    git clone http://github.com/tacahiroy/loga-zsh-completion.git
    ln -s _loga_zsh_completion.zsh ~/.zsh/func/
のようにしてください。もちろん、
    cp _loga_zsh_completion.zsh ~/.zsh/func/
でもOKです。

## タスク:
`loga` コマンドに続いてタスクが補完されます

## タスクの引数と補完される内容:
例)
`task [OPTION1] [OPTION2] [--something]`  
-> `補完1`, `補完2`...

`config [KEY] [VALUE] [--global(optional)]`  
-> `KEY`, `--global`

`delete [SOURCE TERM] [TARGET TERM(optional)] [--force(optional)]`  
-> `SOURCE TERM`, `TARGET TERM`, `--force`

`help [TASK]`  
-> `TASK`

`import`  
-> `loga import --list` で得られるプロジェクト名

`lookup [TERM]`  
-> `TERM`, `--no-pager`, `--no-color`, `--output={csv|json}`, `--dictionary`

`list`  
-> `--no-pager`

`show`  
-> `--no-pager`

`update [SOURCE TERM] [TARGET TERM] [NEW TARGET TERM], [NOTE(optional)]`  
-> `SOURCE TERM`,  `TARGET TERM`,  `NEW TARGET TERM`  
`NEW TARGET TERM` は、`TARGET TERM` と同じ内容を補完

    add [SOURCE TERM] [TARGET TERM] [NOTE(optional)]
    new [PROJECT NAME] [SOURCE LANGUAGE] [TARGET LANGUAGE(optional)]
    register
    unregister
    version
-> オプションのみ


## オプション:
オプションは、すべてのコマンドに対して補完されます(`help`は除く)。
補完位置は常に最後です。

    [--glossary=GLOSSARY]
    [--source-language=SOURCE-LANGUAGE]
    [--target-language=TARGET-LANGUAGE]
    [--logaling-home=LOGALING-HOME]
    [--logaling-config=LOGALING-CONFIG]


## リンク
About logaling-command, see GitHub page:
 [logaling-command](https://github.com/logaling/logaling-command)

