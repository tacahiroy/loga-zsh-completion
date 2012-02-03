#compdef loga

_is_project_dir() {
  $(loga show | grep -e '^input glossary name' 2>&1 > /dev/null)
  is_project_dir=$?
} 

_loga_terms() {
  # trim TARGET TERM and NOTE
  terms=(`loga show | sed -e 's/[ ]\{11,\}[^ ].*$//'`)
  compadd $@ -k terms
}

_loga_glossaries() {
  glossaries=(`loga list`)
  compadd $@ -k glossaries
}

_loga_tasks() {
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

_loga_delete_flags() {
  _args=("--force")
  compadd "$@" -k _args
}

_loga_config_flags() {
  _args=("--global")
  compadd "$@" -k _args
}

local -a _1st_arguments
_1st_arguments=(
  "add:Add term to glossary"
  "config:Set config"
  "delete:Delete term"
  "help:Describe available tasks or one specific task"
  "import:Import external glossary"
  "list:Show glossary list"
  "lookup:Lookup terms"
  "new:Create .logaling"
  "register:Register .logaling"
  "show:Show terms in glossary"
  "unregister:Unregister .logaling"
  "update:Update term"
  "version:Show version"
)

# local -a terms glossaries is_project_dir
# _is_project_dir

loga_global_flags=(
  "(-g --glossary=GLOSSARY)"{-g,--glossary=-}"[Set glossary]:glossaries:->glossary"
  "(-S --source-language=SOURCE-LANGUAGE)"{-S,--source-language=-}"[Set source language]"
  "(-T --target-language=TARGET-LANGUAGE)"{-T,--target-language=-}"[Set target language]"
  "(-h --logaling-home=LOGALING-HOME)"{-h,--logaling-home=-}"[Set logaling home]"
)

_arguments \
  "*:: :->subcmds" && return 0

if (( CURRENT == 1 )); then
  _describe -t commands "loga subcommand" _1st_arguments
  return
fi

case "$words[1]" in
  add|import|list|new|unregister|version)
    _arguments \
      $loga_global_flags
    ;;
  config)
    _arguments \
      ":key:" \
      ":value:" \
      ":flags:_loga_config_flags" \
      $loga_global_flags
    ;;
  delete)
    _arguments \
      ":term:_loga_terms" \
      ":flags:_loga_delete_flags" \
      $loga_global_flags
    ;;
  help)
    _arguments \
      ":task:_loga_tasks" \
      $loga_global_flags
    ;;
  lookup)
    _arguments \
      ":term:_loga_terms" \
      $loga_global_flags
    ;;
  update)
    _arguments \
      ":source:_loga_terms" \
      ":target:" \
      ":new_target:" \
      $loga_global_flags
    ;;
  show)
    _arguments \
      $loga_global_flags
    ;;
esac

