#compdef loga

_loga_source_terms() {
  # trim TARGET TERM and NOTE
  # GNU sed is preferable ...
  terms=(${(f)"$(loga show | sed -e 's/[ ]\{11,\}[^ ].*$//;s/^[ ]*//')"})
  compadd $@ -k terms
}

_loga_target_terms() {
  src=$(print $words[2] | sed -e 's/"//g')
  if [[ "$src" != "" ]]; then
    target_terms=(${(f)"$(loga lookup "${src}" | tr '\t' '#' | \
                          sed -e 's/^[ ]\{2,\}.*[ ]\{11,\}//;s/#\{1,\}.*//')"})
    compadd $@ -k target_terms
  fi
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

loga_global_flags=(
  "(-g --glossary=GLOSSARY)"{-g,--glossary=-}"[Set glossary]:glossaries:->glossary"
  "(-S --source-language=SOURCE-LANGUAGE)"{-S,--source-language=-}"[Set source language]"
  "(-T --target-language=TARGET-LANGUAGE)"{-T,--target-language=-}"[Set target language]"
  "(-h --logaling-home=LOGALING-HOME)"{-h,--logaling-home=-}"[Set logaling home]:directory:_directories"
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
      ":source:_loga_source_terms" \
      ":target:_loga_target_terms" \
      ":flags:_loga_delete_flags" \
      $loga_global_flags
    ;;
  help)
    _arguments \
      ":task:_loga_tasks"
    ;;
  lookup)
    _arguments \
      ":source:_loga_source_terms" \
      $loga_global_flags
    ;;
  update)
    _arguments \
      ":source:_loga_source_terms" \
      ":target:_loga_target_terms" \
      ":new_target:_loga_target_terms" \
      $loga_global_flags
    ;;
  show)
    _arguments \
      $loga_global_flags
    ;;
esac

case "$state" in
  glossary)
    _loga_glossaries
    ;;
esac
