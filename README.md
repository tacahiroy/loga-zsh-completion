logaling-command zsh completion file
===========

logaling-command の zsh 補完定義ファイルです。現在、version 0.1.2 に対応しています。  
必要そうなものは大体実装されています(のつもりです)。

## タスク:
`loga` コマンドに続いてタスクが補完されます

## タスクの引数と補完される内容:
例)
`task [OPTION1] [OPTION2] [--something]`  
`補完1`, `補完2`...

`config [KEY] [VALUE] [--global(optional)]`  
-> `KEY`, `--global`

`delete [SOURCE TERM] [TARGET TERM(optional)] [--force(optional)]`  
-> `SOURCE TERM`, `TARGET TERM`, `--force`

`help [TASK]`  
-> `TASK` を補完

`import`  
-> `loga import --list` で得られるプロジェクト名

`lookup [TERM]`  
-> `TERM`

`update [SOURCE TERM] [TARGET TERM] [NEW TARGET TERM], [NOTE(optional)]`  
-> `SOURCE TERM`,  `TARGET TERM`,  `NEW TARGET TERM`  
`NEW TARGET TERM` は、`TARGET TERM` と同じ内容を補完

    add [SOURCE TERM] [TARGET TERM] [NOTE(optional)]
    list
    new [PROJECT NAME] [SOURCE LANGUAGE] [TARGET LANGUAGE(optional)]
    register
    show
    unregister
    version
オプションのみ


## オプション:
オプションは、すべてのコマンドに対して補完されます(`help`は除く)。
補完位置は常に最後です。

    -g, [--glossary=GLOSSARY]
    -S, [--source-language=SOURCE-LANGUAGE]
    -T, [--target-language=TARGET-LANGUAGE]
    -h, [--logaling-home=LOGALING-HOME]


## リンク
About logaling-command, see github page:
 [logaling-command](https://github.com/logaling/logaling-command)

