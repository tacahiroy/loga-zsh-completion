#compdef loga
# Version: 0.3.0-013
# Author: Takahiro YOSHIHARA <tacahiroy```AT```gmail.com>
# supports logaling-command-0.1.3
#
# License: The MIT License
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

_loga_source_terms() {
  # trim TARGET TERM and NOTE
  # GNU sed is preferable ...
  terms=(${(f)"$(loga show --no-pager | sed -e 's/[ ]\{11,\}[^ ].*$//;s/^[ ]*//')"})
  compadd $@ -k terms
}

_loga_target_terms() {
  src=$(print $words[2] | sed -e 's/"//g')
  if [[ "${src}" != "" ]]; then
    # FIXME: easier way
    target_terms=(${(f)"$(loga lookup "${src}" --no-pager --no-color --output=json | \
                  grep -C1 "^  \"source\": \"${src}\"," | grep '"target":' | \
                  sed -e 's/[ \"]//g;s/,$//' | awk -F: '{print $2}')"})
    compadd $@ -k target_terms
  fi
}

_loga_glossaries() {
  glossaries=(`loga list --no-pager | tr -d ' '`)
  compadd $@ -k glossaries
}

_loga_output_type() {
  types=(csv json)
  compadd $@ -k types
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

#"--output=-[output type]:types:->output_type" \
loga_global_flags=(
  "--glossary=-[glossary name]:glossaries:->glossary"
  "--source-language=-[source language(e.g. en)]"
  "--target-language=-[target language(e.g. ja)]"
  "--logaling-home=-[logaling home]:directory:_directories"
  "--logaling-config=-[.logaling directory]:directory:_directories"
)

_arguments \
  "*:: :->subcmds" && return 0

if (( CURRENT == 1 )); then
  _describe -t commands "loga subcommand" _tasks
  return
fi

case "$words[1]" in
  add|new|unregister)
    _arguments \
      $loga_global_flags
    ;;
  import)
    _arguments \
      ":projects:_loga_importable_projects" \
      "--list"
    ;;
  config)
    _arguments \
      ":key:_loga_config_keys" \
      ":value:" \
      "--global" \
      $loga_global_flags
    ;;
  delete)
    _arguments \
      ":source:_loga_source_terms" \
      ":target:_loga_target_terms" \
      "--force" \
      $loga_global_flags
    ;;
  lookup)
    _arguments \
      ":source:_loga_source_terms" \
      "--no-pager" \
      "--no-color" \
      "--output=-[output type]:types:->output_type" \
      $loga_global_flags && ret=0
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
      "--no-pager" \
      $loga_global_flags
    ;;
  list)
    _arguments \
      "--no-pager" \
      $loga_global_flags
    ;;
  help)
    _arguments \
      ":task:_loga_tasks"
    ;;
esac

case "$state" in
  glossary)
    _loga_glossaries
    ;;
  output_type)
    _loga_output_type
    ;;
esac

# vim: fen:fdm=marker
