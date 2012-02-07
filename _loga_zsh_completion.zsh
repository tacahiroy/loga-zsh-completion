#compdef loga
# Version: 0.3.0
# Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>
# License: MIT License
# Copyright 2012 Takahiro YOSHIHARA # {{{
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# The software is provided "as is", without warranty of any kind, express or
# implied, including but not limited to the warranties of merchantability,
# fitness for a particular purpose and noninfringement. In no event shall the
# authors or copyright holders be liable for any claim, damages or other
# liability, whether in an action of contract, tort or otherwise, arising from,
# out of or in connection with the software or the use or other dealings in the
# software.
# }}}

_loga_config_keys() {
  keys=(glossary source-language target-language)
  compadd $@ -k keys
}

_loga_config_flags() {
  _flags=("--global")
  compadd $@ -k _flags
}

_loga_import_flags() {
  _flags=("--list")
  compadd $@ -k _flags
}

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

_loga_importable_projects() {
  projects=(${(f)"$(loga import --list | sed -e 's/[ ]\{1,\}:.*$//')"})
  compadd $@ -k projects
}

_loga_tasks() {
  _tasks=(
    "add"
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
  compadd "$@" -k _tasks
}

_loga_delete_flags() {
  _flags=("--force")
  compadd "$@" -k _flags
}

local -a _tasks
_tasks=(
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
  "version:Show version")

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
  _describe -t commands "loga subcommand" _tasks
  return
fi

case "$words[1]" in
  add|list|new|unregister)
    _arguments \
      $loga_global_flags
    ;;
  import)
    _arguments \
      ":projects:_loga_importable_projects" \
      ":flags:_loga_import_flags" \
      $loga_global_flags
    ;;
  config)
    _arguments \
      ":key:_loga_config_keys" \
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

# vim: fdm=marker
