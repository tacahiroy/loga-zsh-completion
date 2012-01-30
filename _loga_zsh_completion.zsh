#compdef loga

_is_project_dir() {
  $(loga show | grep -e '^input glossary name' 2>&1 > /dev/null)
  is_project_dir=$?
} 

_loga_terms() {
  terms=(`loga show`)
}

_loga_glossaries() {
  glossaries=(`loga list`)
}

_loga_help_arguments() {
  _args=("add"
  "config"
  "delete"
  "help"
  "import"
  "list"
  "lookup"
  "new"
  "register"
  "show"
  "unregister"
  "update"
  "version")
  compadd "$@" -k _args
}

local -a _1st_arguments
_1st_arguments=(
  'add:Add term to glossary'
  'config:Set config'
  'delete:Delete term'
  'help:Describe available tasks or one specific task'
  'import:Import external glossary'
  'list:Show glossary list'
  'lookup:Lookup terms'
  'new:Create .logaling'
  'register:Register .logaling'
  'show:Show terms in glossary'
  'unregister:Unregister .logaling'
  'update:Update term'
  'version:Show version'
)

local expl
local -a terms glossaries is_project_dir

_is_project_dir

_arguments \
  "(-g --glossary=GLOSSARY)"{-g,--glossary=-}"[Set glossary]:glossaries:->glossary" \
  "(-S --source-language=SOURCE-LANGUAGE)"{-S,--source-language=-}"[Set source language]" \
  "(-T --target-language=TARGET-LANGUAGE)"{-T,--target-language=-}"[Set target language]" \
  "(-h --logaling-home=LOGALING-HOME)"{-h,--logaling-home=-}"[Set logaling home]" \
  '*:: :->subcmds' && return 0

if (( CURRENT == 1 )); then
  _describe -t commands "loga subcommand" _1st_arguments
  return
fi

case "$words[1]" in
  config)
    _arguments \
      '(--global)--global[]'
    ;;
  delete)
    if [[ $is_project_dir -eq 1 ]]; then
      _arguments \
        ":argument:->term"
    else
      _arguments \
        "(--force)--force[]"
    fi
    ;;
  help)
    _arguments \
      ":argument:_loga_help_arguments"
    ;;
  lookup|update)
    if [[ $is_project_dir -eq 1 ]]; then
      _arguments \
        ":argument:->term"
    fi
    ;;
  show)
    if [[ $is_project_dir -eq 0 ]]; then
      _arguments \
        '(-g)-g[Please input glossary name]:::->glossary'
    fi
    ;;
esac

case "$state" in
  glossary)
    _loga_glossaries
    _wanted glossaries expl glossary \
      compadd - $glossaries
    ;;
  term)
    _loga_terms
    _wanted terms expl term \
      compadd - $terms
    ;;
esac
