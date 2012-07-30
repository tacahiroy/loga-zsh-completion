logaling-command zsh completion definition
===========

This is a completion definition file of logaling-command. And now, this supports version 0.1.7.
Almost of requirements have been implemented.

## INSTALL
Please locate in directory where other completion files are located.
For example,

    git clone http://github.com/tacahiroy/loga-zsh-completion.git
    ln -s _loga_zsh_completion.zsh ~/.zsh/func/

or following way also available,

    cp _loga_zsh_completion.zsh ~/.zsh/func/

## TASKS
The task will be completed after `loga` command.

## Arguments of task and completion details
e.g.)
`task [OPTION1] [OPTION2] [--something]`  
-> `candidate 1`, `candidate 2`...

`config [KEY] [VALUE] [--global(optional)]`  
-> `KEY`, `--global`

`delete [SOURCE TERM] [TARGET TERM(optional)] [--force(optional)]`  
-> `SOURCE TERM`, `TARGET TERM`, `--force`

`help [TASK]`  
-> `TASK`

`import`  
-> project names that can get command `loga import --list`

`lookup [TERM]`  
-> `TERM`, `--no-pager`, `--no-color`, `--output={csv|json}`, `--dictionary`

`list`  
-> `--no-pager`

`show`  
-> `--no-pager`

`update [SOURCE TERM] [TARGET TERM] [NEW TARGET TERM], [NOTE(optional)]`  
-> `SOURCE TERM`,  `TARGET TERM`,  `NEW TARGET TERM`  
`NEW TARGET TERM` will be completed same as `TARGET TERM`

    add [SOURCE TERM] [TARGET TERM] [NOTE(optional)]
    new [PROJECT NAME] [SOURCE LANGUAGE] [TARGET LANGUAGE(optional)]
    register
    unregister
    version
-> only options


## OPTIONS
These options will be completed against all commands except `help`
and position is always last.

    [--glossary=GLOSSARY]
    [--source-language=SOURCE-LANGUAGE]
    [--target-language=TARGET-LANGUAGE]
    [--logaling-home=LOGALING-HOME]
    [--logaling-config=LOGALING-CONFIG]

## LIMITATION
About completion of `update`, `delete` and `lookup`, if TERM includes Tab (0x09),  
it wouldn't work correctly.


## LINK
About logaling-command, see GitHub page:
 [logaling-command](https://github.com/logaling/logaling-command)

